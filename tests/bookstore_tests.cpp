// SPDX-License-Identifier: 0BSD
#include "bookstore.hpp"
#include <iostream>
#include <string_view>
using swe::bookstore::parse_query;
using swe::bookstore::filter_books;
using swe::bookstore::http_response;

namespace {
int failures = 0;
void check(bool condition, std::string_view name) {
  if (!condition) {
    ++failures;
    std::cerr << "BOOKSTORE|TEST_FAIL|" << name << '\n';
  }
}
}
int main() {
  const auto all = parse_query("");
  check(all.has_value(), "empty_query");
  if (all) check(filter_books(*all).size() == 5, "all_five_books");
  const auto name = parse_query("name=The+Hobbit");
  check(name.has_value(), "name_query");
  if (name) check(filter_books(*name).size() == 1, "name_filter");
  const auto author = parse_query("author=JRR%20Tolkien");
  check(author.has_value(), "author_query");
  if (author) check(filter_books(*author).size() == 2, "author_filter");
  const auto unread = parse_query("read=false");
  check(unread.has_value(), "unread_query");
  if (unread) check(filter_books(*unread).size() == 2, "unread_filter");
  check(!parse_query("name=x%0A"), "reject_control");
  check(!parse_query("name=x%00"), "reject_nul");
  check(!parse_query("name=x%GG"), "reject_malformed_hex");
  check(!parse_query("read=maybe"), "reject_bad_bool");
  check(!parse_query("name=a&name=b"), "reject_duplicate");
  check(!parse_query("injected=x"), "reject_unknown_parameter");
  check(http_response("GET", "/").find("HTTP/1.1 200 OK") == 0, "http_200");
  check(http_response("GET", "/").find("The Hobbit") !=
        std::string::npos, "render_books");
  check(http_response("GET", "/").find("Content-Security-Policy: default-src 'none'") !=
        std::string::npos, "response_csp");
  const auto rejected_method = http_response("POST", "/");
  check(rejected_method.find("405 Method Not Allowed") !=
        std::string::npos, "method_guard");
  check(rejected_method.find("\r\nAllow: GET\r\n") !=
        std::string::npos, "method_guard_allow_get");
  check(http_response("GET", "/").find("\r\nAllow: GET\r\n") ==
        std::string::npos, "allow_header_only_on_405");
  check(http_response("GET", "/?name=x%0A").find("400 Bad Request") !=
        std::string::npos, "query_guard");
  check(http_response("GET", "/invalid").find("404 Not Found") !=
        std::string::npos, "unknown_route");
  check(swe::bookstore::escape_html("<&\"'>") == "&lt;&amp;&quot;&#39;&gt;",
        "html_escape");
  if (failures) return 1;
  std::cout << "BOOKSTORE|TEST_PASS|CXX20\n";
  return 0;
}
