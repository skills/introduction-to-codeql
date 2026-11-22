// SPDX-License-Identifier: 0BSD
#include "bookstore.hpp"
#include <array>
#include <cstddef>
#include <set>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

namespace swe::bookstore {
namespace {
constexpr std::array<Book, 5> kBooks{{
  {"The Hobbit", "JRR Tolkien", true},
  {"The Fellowship of the Ring", "JRR Tolkien", true},
  {"The Eye of the World", "Robert Jordan", false},
  {"A Game of Thrones", "George R. R. Martin", true},
  {"The Way of Kings", "Brandon Sanderson", false}
}};

[[nodiscard]] int hex_value(char c) noexcept {
  if (c >= '0' && c <= '9') return c - '0';
  if (c >= 'a' && c <= 'f') return c - 'a' + 10;
  if (c >= 'A' && c <= 'F') return c - 'A' + 10;
  return -1;
}
[[nodiscard]] bool decode(std::string_view text, std::string& output) {
  output.clear();
  if (text.size() > 2048) return false;
  for (std::size_t i = 0; i < text.size(); ++i) {
    unsigned char c = static_cast<unsigned char>(text[i]);
    if (c == '%') {
      if (text.size() - i < 3) return false;
      const int hi = hex_value(text[i + 1]);
      const int lo = hex_value(text[i + 2]);
      if (hi < 0 || lo < 0) return false;
      c = static_cast<unsigned char>((hi << 4) | lo);
      i += 2;
    } else if (c == '+') {
      c = ' ';
    }
    // No NUL, CR/LF, raw control characters, or DEL in HTTP query fields.
    if (c < 0x20U || c == 0x7fU) return false;
    output.push_back(static_cast<char>(c));
  }
  return true;
}
[[nodiscard]] char ascii_lower(char c) noexcept {
  return (c >= 'A' && c <= 'Z') ? static_cast<char>(c - 'A' + 'a') : c;
}
[[nodiscard]] bool contains_ci(std::string_view text, std::string_view sub) noexcept {
  if (sub.size() > text.size()) return false;
  for (std::size_t i = 0; i + sub.size() <= text.size(); ++i) {
    bool match = true;
    for (std::size_t j = 0; j < sub.size(); ++j) {
      if (ascii_lower(text[i + j]) != ascii_lower(sub[j])) {
        match = false;
        break;
      }
    }
    if (match) return true;
  }
  return false;
}
[[nodiscard]] std::string respond(int status, std::string_view reason,
                                  std::string_view body, std::string_view mime) {
  std::string data;
  data.reserve(body.size() + 320);
  data += "HTTP/1.1 ";
  data += std::to_string(status);
  data += " ";
  data += reason;
  if (status == 405) data += "\r\nAllow: GET";
  data += "\r\nContent-Type: ";
  data += mime;
  data += "\r\nContent-Length: ";
  data += std::to_string(body.size());
  data += "\r\nConnection: close\r\nCache-Control: no-store";
  data += "\r\nX-Content-Type-Options: nosniff";
  data += "\r\nContent-Security-Policy: default-src 'none'; base-uri 'none'";
  data += "\r\n\r\n";
  data += body;
  return data;
}
} // namespace

std::optional<Query> parse_query(std::string_view raw) {
  if (raw.size() > 2048) return std::nullopt;
  Query query{};
  if (raw.empty()) return query;
  std::set<std::string> seen;
  std::size_t begin = 0;
  while (begin < raw.size()) {
    const auto end = raw.find('&', begin);
    const auto item = raw.substr(begin,
      end == std::string_view::npos ? std::string_view::npos : end - begin);
    const auto pos = item.find('=');
    if (pos == std::string_view::npos) return std::nullopt;
    std::string key;
    std::string value;
    if (!decode(item.substr(0, pos), key) ||
        !decode(item.substr(pos + 1), value) ||
        value.size() > 128 || !seen.insert(key).second) return std::nullopt;
    if (key == "name") {
      query.name = std::move(value);
    } else if (key == "author") {
      query.author = std::move(value);
    } else if (key == "read") {
      if (value == "true" || value == "1") query.read = true;
      else if (value == "false" || value == "0") query.read = false;
      else return std::nullopt;
    } else {
      return std::nullopt;
    }
    if (end == std::string_view::npos) break;
    begin = end + 1;
    if (begin == raw.size()) return std::nullopt;
  }
  return query;
}
std::vector<Book> filter_books(const Query& query) {
  std::vector<Book> result;
  for (const Book& book : kBooks) {
    // Retain original tutorial precedence: name over author.
    if (!query.name.empty()) {
      if (!contains_ci(book.name, query.name)) continue;
    } else if (!query.author.empty() && !contains_ci(book.author, query.author)) {
      continue;
    }
    if (query.read.has_value() && book.read != *query.read) continue;
    result.push_back(book);
  }
  return result;
}
std::string escape_html(std::string_view input) {
  std::string out;
  out.reserve(input.size());
  for (const char c : input) {
    switch (c) {
      case '&': out += "&amp;"; break;
      case '<': out += "&lt;"; break;
      case '>': out += "&gt;"; break;
      case '"': out += "&quot;"; break;
      case '\'': out += "&#39;"; break;
      default: out.push_back(c); break;
    }
  }
  return out;
}
std::string render_page(const Query& query) {
  std::string out = "<!doctype html>\n<html lang=\"en\"><head>"
    "<meta charset=\"utf-8\"><title>Book Store</title>"
    "</head><body><h1>Book Store</h1><ul id=\"books\">";
  for (const Book& book : filter_books(query)) {
    out += "<li>";
    out += escape_html(book.name);
    out += " by ";
    out += escape_html(book.author);
    out += "</li>";
  }
  out += "</ul></body></html>\n";
  return out;
}
std::string http_response(std::string_view method, std::string_view target) {
  if (method != "GET")
    return respond(405, "Method Not Allowed", "GET only\n", "text/plain; charset=utf-8");
  if (target.size() > 2048 || target.find('#') != std::string_view::npos)
    return respond(400, "Bad Request", "Invalid target\n", "text/plain; charset=utf-8");
  const auto pos = target.find('?');
  if (target.substr(0, pos) != "/")
    return respond(404, "Not Found", "Not found\n", "text/plain; charset=utf-8");
  const auto query = parse_query(pos == std::string_view::npos
    ? std::string_view{} : target.substr(pos + 1));
  if (!query)
    return respond(400, "Bad Request", "Invalid query\n", "text/plain; charset=utf-8");
  const std::string body = render_page(*query);
  return respond(200, "OK", body, "text/html; charset=utf-8");
}
} // namespace swe::bookstore
