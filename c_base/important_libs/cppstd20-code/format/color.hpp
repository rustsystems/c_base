//********************************************************
// The following code example is taken from the book
//  C++20 - The Complete Guide
//  by Nicolai M. Josuttis (www.josuttis.com)
//  http://www.cppstd20.com
//
// The code is licensed under a
//  Creative Commons Attribution 4.0 International License
//  http://creativecommons.org/licenses/by/4.0/
//********************************************************


#include <format>
#include <string_view>

enum class Color { red, green, blue };

//*** formatter for enum type Color:
template<>
struct std::formatter<Color>
{
  // use a standard string formatter that does most of the work:
#if __cpp_lib_format < 202106
  mutable    // in case the standard formatters have a non-const format()
#endif
  std::formatter<std::string_view> f;

  // delegate parsing to the standard string formatter:
#if __cpp_lib_format >= 202106
  constexpr  // in case standard formatters don't support constexpr parse() yet
#endif
  auto parse(std::format_parse_context& ctx) {
    return f.parse(ctx);
  }

  auto format(Color c, format_context& ctx) const {
    // initialize a string for the value:
    std::string_view value = "<unknown Color>";
    using enum Color;
    switch (c) {
      case red:
        value = "red";
        break;
      case green:
        value = "green";
        break;
      case blue:
        value = "blue";
        break;
    }
    // and delegate the rest of formatting to the string formatter:
    return f.format(value, ctx);
  }
};

