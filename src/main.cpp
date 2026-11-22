// SPDX-License-Identifier: 0BSD
// Windows feature macros are supplied once by the CMake target.
#include <winsock2.h>
#include <ws2tcpip.h>
#include "bookstore.hpp"
#include <array>
#include <charconv>
#include <cstddef>
#include <iostream>
#include <string>
#include <string_view>

namespace {
[[nodiscard]] bool parse_int(std::string_view text, int low, int high, int& output) noexcept {
  int parsed = 0;
  const auto result = std::from_chars(text.data(), text.data() + text.size(), parsed);
  if (result.ec != std::errc{} ||
      result.ptr != text.data() + text.size() ||
      parsed < low || parsed > high) return false;
  output = parsed;
  return true;
}
[[nodiscard]] bool send_all(SOCKET socket, std::string_view text) {
  std::size_t position = 0;
  while (position < text.size()) {
    const int sent = send(socket, text.data() + position,
      static_cast<int>(text.size() - position), 0);
    if (sent <= 0) return false;
    position += static_cast<std::size_t>(sent);
  }
  return true;
}
[[nodiscard]] std::string dispatch(std::string_view data) {
  const auto end = data.find("\r\n");
  if (end == std::string_view::npos || end > 4096) {
    return "HTTP/1.1 400 Bad Request\r\nContent-Length: 0\r\nConnection: close\r\n\r\n";
  }
  const auto line = data.substr(0, end);
  const auto first = line.find(' ');
  const auto second = first == std::string_view::npos ?
    std::string_view::npos : line.find(' ', first + 1);
  if (second == std::string_view::npos ||
      line.find(' ', second + 1) != std::string_view::npos ||
      (line.substr(second + 1) != "HTTP/1.1" &&
       line.substr(second + 1) != "HTTP/1.0")) {
    return "HTTP/1.1 400 Bad Request\r\nContent-Length: 0\r\nConnection: close\r\n\r\n";
  }
  return swe::bookstore::http_response(
    line.substr(0, first), line.substr(first + 1, second - first - 1));
}
void serve_one(SOCKET client) {
  constexpr int timeout_ms = 5000;
  static_cast<void>(setsockopt(client, SOL_SOCKET, SO_RCVTIMEO,
    reinterpret_cast<const char*>(&timeout_ms), sizeof(timeout_ms)));
  static_cast<void>(setsockopt(client, SOL_SOCKET, SO_SNDTIMEO,
    reinterpret_cast<const char*>(&timeout_ms), sizeof(timeout_ms)));
  constexpr std::size_t max_header = 8192;
  std::string request;
  request.reserve(1024);
  std::array<char, 2048> chunk{};
  while (request.find("\r\n\r\n") == std::string::npos &&
         request.size() <= max_header) {
    const int n = recv(client, chunk.data(), static_cast<int>(chunk.size()), 0);
    if (n <= 0) return;
    request.append(chunk.data(), static_cast<std::size_t>(n));
  }
  if (request.size() > max_header) {
    static_cast<void>(send_all(client,
      "HTTP/1.1 431 Request Header Fields Too Large\r\n"
      "Content-Length: 0\r\nConnection: close\r\n\r\n"));
    return;
  }
  const std::string reply = dispatch(request);
  static_cast<void>(send_all(client, reply));
}
} // namespace

int main(int argc, char** argv) {
  int port = 8080;
  int max_requests = 0;
  for (int i = 1; i < argc; ++i) {
    const std::string_view option{argv[i]};
    if (option == "--help") {
      std::cout << "bookstore [--port 1024..65535] [--max-requests 1..1000]\n";
      return 0;
    }
    if (i + 1 >= argc) return 2;
    const std::string_view value{argv[++i]};
    if (option == "--port") {
      if (!parse_int(value, 1024, 65535, port)) return 2;
    } else if (option == "--max-requests") {
      if (!parse_int(value, 1, 1000, max_requests)) return 2;
    } else {
      return 2;
    }
  }
  WSADATA wsa{};
  if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0) return 1;
  const SOCKET listener = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if (listener == INVALID_SOCKET) {
    WSACleanup();
    return 1;
  }
  sockaddr_in addr{};
  addr.sin_family = AF_INET;
  addr.sin_port = htons(static_cast<u_short>(port));
  addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
  if (bind(listener, reinterpret_cast<const sockaddr*>(&addr), sizeof(addr)) == SOCKET_ERROR ||
      listen(listener, 8) == SOCKET_ERROR) {
    std::cerr << "BOOKSTORE|HOLD|bind_or_listen_failed\n";
    closesocket(listener);
    WSACleanup();
    return 1;
  }
  std::cout << "BOOKSTORE|LISTEN=127.0.0.1:" << port << std::endl;
  int served = 0;
  while (max_requests == 0 || served < max_requests) {
    const SOCKET client = accept(listener, nullptr, nullptr);
    if (client == INVALID_SOCKET) break;
    serve_one(client);
    closesocket(client);
    ++served;
  }
  closesocket(listener);
  WSACleanup();
  return max_requests != 0 && served != max_requests ? 1 : 0;
}
