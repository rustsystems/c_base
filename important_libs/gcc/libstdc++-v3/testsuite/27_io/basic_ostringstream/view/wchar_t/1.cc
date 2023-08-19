// Copyright (C) 2020-2023 Free Software Foundation, Inc.
//
// This file is part of the GNU ISO C++ Library.  This library is free
// software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the
// Free Software Foundation; either version 3, or (at your option)
// any later version.

// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License along
// with this library; see the file COPYING3.  If not see
// <http://www.gnu.org/licenses/>.

// 29.8.4.4  basic_ostringstream member functions  [ostringstream.members]

// { dg-options "-std=gnu++2a" }
// { dg-do run { target c++2a } }

#include <sstream>
#include <string_view>
#include <testsuite_hooks.h>

int
main()
{
  std::wstring s(L"This is a test");
  std::wostringstream stm(s);
  VERIFY( stm.view() == s );
  VERIFY( stm.view() == const_cast<const std::wostringstream&>(stm).view() );

  s += L" with a longer string";
  stm << s;
  VERIFY( stm.view() == s );

  s = L"This is a shorter string";
  stm.str(s);
  VERIFY( stm.view() == s );
}
