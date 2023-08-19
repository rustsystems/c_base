
Defined in header <assert.h>
assert
 
aborts the program if the user-specified condition is not true. May be disabled for release builds
(function macro)
static_assert
  
(C11)(removed in C23)
 
issues a compile-time diagnostic if the value of a constant expression is false
(keyword macro)
Bounds checking
The standard library provides bounds-checked versions of some existing functions (gets_s, fopen_s, printf_s, strcpy_s, wcscpy_s, mbstowcs_s, qsort_s, getenv_s, etc). This functionality is optional and is only available if __STDC_LIB_EXT1__ is defined. The following macros and functions support this functionality.

Defined in header <errno.h>
Defined in header <stdio.h>
errno_t
  
(C11)
 
a typedef for the type int, used to self-document functions that return errno values
(typedef)
Defined in header <stddef.h>
Defined in header <stdio.h>
Defined in header <stdlib.h>
Defined in header <string.h>
Defined in header <time.h>
Defined in header <wchar.h>
rsize_t
  
(C11)
 
a typedef for the same type as size_t, used to self-document functions that range-check their parameters at runtime
(typedef)
Defined in header <stdint.h>
RSIZE_MAX
  
(C11)
 
largest acceptable size for bounds-checked functions, expands to either constant or variable which may change at runtime (e.g. as the currently allocated memory size changes)
(macro variable)
Defined in header <stdlib.h>
set_constraint_handler_s
  
(C11)
 
set the error callback for bounds-checked functions
(function)
abort_handler_s
  
(C11)
 
abort callback for the bounds-checked functions
(function)
ignore_handler_s
  
(C11)
 
ignore callback for the bounds-checked functions
(function)
Note: implementations of bounds-checked functions are available as open-source libraries Safe C and Slibc, and as part of Watcom C. There is also an incompatible set of bounds-checked functions available in Visual Studio.

(since C11)
Notes
Since C23, static_assert is itself a keyword, which may also be a predefined macro, so <assert.h> no longer provides it.

