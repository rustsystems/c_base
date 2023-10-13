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


#include <iostream>
#include <vector>
#include <utility>
#include <ranges>

int main()
{
  // initialize collection with pairs of int as elements:
  std::vector<std::pair<int,int>> coll{{1,0}, {5,3}, {2,2}, {4,1}, {2,7}};

  // increment the smaller of the two values in each pair:
  auto lessOf1st2nd = [] (std::pair<int,int>& elem) -> int& {
    return elem.first > elem.second ? elem.second : elem.first;
  };
  for (auto&& elem : coll | std::views::transform(lessOf1st2nd)) {
    ++elem;
  }

  // print resulting collection:
  for (const auto& elem : coll) {
    std::cout << elem.first << '/' << elem.second << '\n';  
  }
}

