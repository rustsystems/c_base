/* Test of multibyte character I/O.
   Copyright (C) 2023 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* Written by Bruno Haible <bruno@clisp.org>, 2023.  */

#include <config.h>

#include "mbfile.h"

#include <locale.h>

#include "macros.h"

int
main ()
{
  if (setlocale (LC_ALL, "en_US.UTF-8") == NULL)
    {
      fprintf (stderr, "Skipping test: English Unicode locale is not installed\n");
      return 77;
    }

  mb_file_t mbstdin;
  mbf_init (mbstdin, stdin);
  /* The input consists of 4 UTF-8 characters:
     '$', U+00A5, U+20AC, U+0001F403.  */
  mbf_char_t next;

  mbf_getc (next, mbstdin);
  ASSERT (!mb_iseof (next));
  ASSERT (mb_len (next) == 1);
  ASSERT (mb_iseq (next, 0x0024));

  mbf_getc (next, mbstdin);
  ASSERT (!mb_iseof (next));
  ASSERT (mb_len (next) == 2);
  ASSERT (mb_iseq (next, 0x00A5));

  mbf_getc (next, mbstdin);
  ASSERT (!mb_iseof (next));
  ASSERT (mb_len (next) == 3);
  ASSERT (mb_iseq (next, 0x20AC));

  mbf_getc (next, mbstdin);
  ASSERT (!mb_iseof (next));
  ASSERT (mb_len (next) == 4);
  ASSERT (mb_iseq (next, 0x1F403));

  mbf_getc (next, mbstdin);
  ASSERT (mb_iseof (next));

  return 0;
}
