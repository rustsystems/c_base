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
#include <string>
#include <vector>
#include <ranges>
#include <algorithm>
#include <span>
#include <cassert>

template<typename T, std::size_t Sz>
void printSpan(std::span<T, Sz> sp)
{
  for (const auto& elem : sp) {
    std::cout << '"' << elem << "\" ";
  }
  std::cout << '\n';
}

int main()
{
  std::vector<std::string> vec{"New York", "Tokyo", "Rio", "Berlin", "Sydney"};

  // define view to first 3 elements:
  assert(vec.size() >= 3);
  std::span<const std::string, 3> sp3{vec.begin(), 3};
  std::cout << "first 3: ";
  printSpan(sp3);

  // sort referenced elements:
  std::ranges::sort(vec);
  std::cout << "first 3 after sort(): ";
  printSpan(sp3);

  // insert new element
  // - have to reassign the span if vector did allocate new memory
  auto oldCapa = vec.capacity();
  vec.push_back("Cairo");
  if (oldCapa != vec.capacity()) {
    sp3 = std::span<std::string, 3>{vec.begin(), 3};
  }
  std::cout << "first 3: ";
  printSpan(sp3);

  // assign view to last 3 elements:
  sp3 = std::span<std::string, 3>{vec.end() - 3, vec.end()};
  std::cout << "last 3: ";
  printSpan(sp3);

  // pass vector as span:
  std::cout << "vec: ";
  printSpan(std::span{vec});  // OK (explicit conversion to std::span necessary)
}

