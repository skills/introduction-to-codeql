// SPDX-License-Identifier: 0BSD
#pragma once
#include <optional>
#include <string>
#include <string_view>
#include <vector>

namespace swe::bookstore {
struct Book {
  std::string_view name;
  std::string_view author;
  bool read;
};
struct Query {
  std::string name;
  std::string author;
  std::optional<bool> read;
};
[[nodiscard]] std::optional<Query> parse_query(std::string_view raw);
[[nodiscard]] std::vector<Book> filter_books(const Query& query);
[[nodiscard]] std::string escape_html(std::string_view input);
[[nodiscard]] std::string render_page(const Query& query);
[[nodiscard]] std::string http_response(std::string_view method, std::string_view target);
} // namespace swe::bookstore
