Fixed width integer types (since C99)
 C Type support 
Types
Defined in header <stdint.h>
int8_t
int16_t
int32_t
int64_t	signed integer type with width of
exactly 8, 16, 32 and 64 bits respectively
with no padding bits and using 2's complement for negative values
(provided only if the implementation directly supports the type)
int_fast8_t
int_fast16_t
int_fast32_t
int_fast64_t	fastest signed integer type with width of
at least 8, 16, 32 and 64 bits respectively
int_least8_t
int_least16_t
int_least32_t
int_least64_t	smallest signed integer type with width of
at least 8, 16, 32 and 64 bits respectively
intmax_t	maximum width integer type
intptr_t	integer type capable of holding a pointer
uint8_t
uint16_t
uint32_t
uint64_t	unsigned integer type with width of
exactly 8, 16, 32 and 64 bits respectively
(provided only if the implementation directly supports the type)
uint_fast8_t
uint_fast16_t
uint_fast32_t
uint_fast64_t	fastest unsigned integer type with width of
at least 8, 16, 32 and 64 bits respectively
uint_least8_t
uint_least16_t
uint_least32_t
uint_least64_t	smallest unsigned integer type with width of
at least 8, 16, 32 and 64 bits respectively
uintmax_t	maximum width unsigned integer type
uintptr_t	unsigned integer type capable of holding a pointer
The implementation may define typedef names intN_t, int_fastN_t, int_leastN_t, uintN_t, uint_fastN_t, and uint_leastN_t when N is not 8, 16, 32 or 64. Typedef names of the form intN_t may only be defined if the implementation supports an integer type of that width with no padding. Thus, uint24_t denotes an unsigned integer type with a width of exactly 24 bits.

Each of the macros listed in below is defined if and only if the implementation defines the corresponding typedef name. The macros INTN_C and UINTN_C correspond to the typedef names int_leastN_t and uint_leastN_t, respectively.

Macro constants
Defined in header <stdint.h>
Signed integers : width
INT8_WIDTH
INT16_WIDTH
INT32_WIDTH
INT64_WIDTH
  
(C23)(optional)
 
bit width of an object of type int8_t, int16_t, int32_t, int64_t (exactly 8, 16, 32, 64)
(macro constant)
INT_FAST8_WIDTH
INT_FAST16_WIDTH
INT_FAST32_WIDTH
INT_FAST64_WIDTH
  
(C23)
 
bit width of an object of type int_fast8_t, int_fast16_t, int_fast32_t, int_fast64_t
(macro constant)
INT_LEAST8_WIDTH
INT_LEAST16_WIDTH
INT_LEAST32_WIDTH
INT_LEAST64_WIDTH
  
(C23)
 
bit width of an object of type int_least8_t, int_least16_t, int_least32_t, int_least64_t
(macro constant)
INTPTR_WIDTH
  
(C23)(optional)
 
bit width of an object of type intptr_t
(macro constant)
INTMAX_WIDTH
  
(C23)
 
bit width of an object of type intmax_t
(macro constant)
Signed integers : minimum value
INT8_MIN
INT16_MIN
INT32_MIN
INT64_MIN
 
minimum value of an object of type int8_t, int16_t, int32_t, int64_t
(macro constant)
INT_FAST8_MIN
INT_FAST16_MIN
INT_FAST32_MIN
INT_FAST64_MIN
 
minimum value of an object of type int_fast8_t, int_fast16_t, int_fast32_t, int_fast64_t
(macro constant)
INT_LEAST8_MIN
INT_LEAST16_MIN
INT_LEAST32_MIN
INT_LEAST64_MIN
 
minimum value of an object of type int_least8_t, int_least16_t, int_least32_t, int_least64_t
(macro constant)
INTPTR_MIN
 
minimum value of an object of type intptr_t
(macro constant)
INTMAX_MIN
 
minimum value of an object of type intmax_t
(macro constant)
Signed integers : maximum value
INT8_MAX
INT16_MAX
INT32_MAX
INT64_MAX
 
maximum value of an object of type int8_t, int16_t, int32_t, int64_t
(macro constant)
INT_FAST8_MAX
INT_FAST16_MAX
INT_FAST32_MAX
INT_FAST64_MAX
 
maximum value of an object of type int_fast8_t, int_fast16_t, int_fast32_t, int_fast64_t
(macro constant)
INT_LEAST8_MAX
INT_LEAST16_MAX
INT_LEAST32_MAX
INT_LEAST64_MAX
 
maximum value of an object of type int_least8_t, int_least16_t, int_least32_t, int_least64_t
(macro constant)
INTPTR_MAX
 
maximum value of an object of type intptr_t
(macro constant)
INTMAX_MAX
 
maximum value of an object of type intmax_t
(macro constant)
Unsigned integers : width
UINT8_WIDTH
UINT16_WIDTH
UINT32_WIDTH
UINT64_WIDTH
  
(C23)(optional)
 
bit width of an object of type uint8_t, uint16_t, uint32_t, uint64_t (exactly 8, 16, 32, 64)
(macro constant)
UINT_FAST8_WIDTH
UINT_FAST16_WIDTH
UINT_FAST32_WIDTH
UINT_FAST64_WIDTH
  
(C23)
 
bit width of an object of type uint_fast8_t, uint_fast16_t, uint_fast32_t, uint_fast64_t
(macro constant)
UINT_LEAST8_WIDTH
UINT_LEAST16_WIDTH
UINT_LEAST32_WIDTH
UINT_LEAST64_WIDTH
  
(C23)
 
bit width of an object of type uint_least8_t, uint_least16_t, uint_least32_t, uint_least64_t
(macro constant)
UINTPTR_WIDTH
  
(C23)(optional)
 
bit width of an object of type uintptr_t
(macro constant)
UINTMAX_WIDTH
  
(C23)
 
bit width of an object of type uintmax_t
(macro constant)
Unsigned integers : maximum value
UINT8_MAX
UINT16_MAX
UINT32_MAX
UINT64_MAX
 
maximum value of an object of type uint8_t, uint16_t, uint32_t, uint64_t
(macro constant)
UINT_FAST8_MAX
UINT_FAST16_MAX
UINT_FAST32_MAX
UINT_FAST64_MAX
 
maximum value of an object of type uint_fast8_t, uint_fast16_t, uint_fast32_t, uint_fast64_t
(macro constant)
UINT_LEAST8_MAX
UINT_LEAST16_MAX
UINT_LEAST32_MAX
UINT_LEAST64_MAX
 
maximum value of an object of type uint_least8_t, uint_least16_t, uint_least32_t, uint_least64_t
(macro constant)
UINTPTR_MAX
 
maximum value of an object of type uintptr_t
(macro constant)
UINTMAX_MAX
 
maximum value of an object of type uintmax_t
(macro constant)
Function macros for minimum-width integer constants
INT8_C
INT16_C
INT32_C
INT64_C
 
expands to an integer constant expression having the value specified by its argument and the type int_least8_t, int_least16_t, int_least32_t, int_least64_t respectively
(function macro)
INTMAX_C
 
expands to an integer constant expression having the value specified by its argument and the type intmax_t
(function macro)
UINT8_C
UINT16_C
UINT32_C
UINT64_C
 
expands to an integer constant expression having the value specified by its argument and the type uint_least8_t, uint_least16_t, uint_least32_t, uint_least64_t respectively
(function macro)
UINTMAX_C
 
expands to an integer constant expression having the value specified by its argument and the type uintmax_t
(function macro)
#include <stdint.h>
UINT64_C(0x123) // might expand to 0x123ULL or 0x123UL
Format macro constants





Fixed width integer types (since C99)
 C Type support 
Types
Defined in header <stdint.h>
int8_t
int16_t
int32_t
int64_t	signed integer type with width of
exactly 8, 16, 32 and 64 bits respectively
with no padding bits and using 2's complement for negative values
(provided only if the implementation directly supports the type)
int_fast8_t
int_fast16_t
int_fast32_t
int_fast64_t	fastest signed integer type with width of
at least 8, 16, 32 and 64 bits respectively
int_least8_t
int_least16_t
int_least32_t
int_least64_t	smallest signed integer type with width of
at least 8, 16, 32 and 64 bits respectively
intmax_t	maximum width integer type
intptr_t	integer type capable of holding a pointer
uint8_t
uint16_t
uint32_t
uint64_t	unsigned integer type with width of
exactly 8, 16, 32 and 64 bits respectively
(provided only if the implementation directly supports the type)
uint_fast8_t
uint_fast16_t
uint_fast32_t
uint_fast64_t	fastest unsigned integer type with width of
at least 8, 16, 32 and 64 bits respectively
uint_least8_t
uint_least16_t
uint_least32_t
uint_least64_t	smallest unsigned integer type with width of
at least 8, 16, 32 and 64 bits respectively
uintmax_t	maximum width unsigned integer type
uintptr_t	unsigned integer type capable of holding a pointer
The implementation may define typedef names intN_t, int_fastN_t, int_leastN_t, uintN_t, uint_fastN_t, and uint_leastN_t when N is not 8, 16, 32 or 64. Typedef names of the form intN_t may only be defined if the implementation supports an integer type of that width with no padding. Thus, uint24_t denotes an unsigned integer type with a width of exactly 24 bits.

Each of the macros listed in below is defined if and only if the implementation defines the corresponding typedef name. The macros INTN_C and UINTN_C correspond to the typedef names int_leastN_t and uint_leastN_t, respectively.

Macro constants
Defined in header <stdint.h>
Signed integers : width
INT8_WIDTH
INT16_WIDTH
INT32_WIDTH
INT64_WIDTH
  
(C23)(optional)
 
bit width of an object of type int8_t, int16_t, int32_t, int64_t (exactly 8, 16, 32, 64)
(macro constant)
INT_FAST8_WIDTH
INT_FAST16_WIDTH
INT_FAST32_WIDTH
INT_FAST64_WIDTH
  
(C23)
 
bit width of an object of type int_fast8_t, int_fast16_t, int_fast32_t, int_fast64_t
(macro constant)
INT_LEAST8_WIDTH
INT_LEAST16_WIDTH
INT_LEAST32_WIDTH
INT_LEAST64_WIDTH
  
(C23)
 
bit width of an object of type int_least8_t, int_least16_t, int_least32_t, int_least64_t
(macro constant)
INTPTR_WIDTH
  
(C23)(optional)
 
bit width of an object of type intptr_t
(macro constant)
INTMAX_WIDTH
  
(C23)
 
bit width of an object of type intmax_t
(macro constant)
Signed integers : minimum value
INT8_MIN
INT16_MIN
INT32_MIN
INT64_MIN
 
minimum value of an object of type int8_t, int16_t, int32_t, int64_t
(macro constant)
INT_FAST8_MIN
INT_FAST16_MIN
INT_FAST32_MIN
INT_FAST64_MIN
 
minimum value of an object of type int_fast8_t, int_fast16_t, int_fast32_t, int_fast64_t
(macro constant)
INT_LEAST8_MIN
INT_LEAST16_MIN
INT_LEAST32_MIN
INT_LEAST64_MIN
 
minimum value of an object of type int_least8_t, int_least16_t, int_least32_t, int_least64_t
(macro constant)
INTPTR_MIN
 
minimum value of an object of type intptr_t
(macro constant)
INTMAX_MIN
 
minimum value of an object of type intmax_t
(macro constant)
Signed integers : maximum value
INT8_MAX
INT16_MAX
INT32_MAX
INT64_MAX
 
maximum value of an object of type int8_t, int16_t, int32_t, int64_t
(macro constant)
INT_FAST8_MAX
INT_FAST16_MAX
INT_FAST32_MAX
INT_FAST64_MAX
 
maximum value of an object of type int_fast8_t, int_fast16_t, int_fast32_t, int_fast64_t
(macro constant)
INT_LEAST8_MAX
INT_LEAST16_MAX
INT_LEAST32_MAX
INT_LEAST64_MAX
 
maximum value of an object of type int_least8_t, int_least16_t, int_least32_t, int_least64_t
(macro constant)
INTPTR_MAX
 
maximum value of an object of type intptr_t
(macro constant)
INTMAX_MAX
 
maximum value of an object of type intmax_t
(macro constant)
Unsigned integers : width
UINT8_WIDTH
UINT16_WIDTH
UINT32_WIDTH
UINT64_WIDTH
  
(C23)(optional)
 
bit width of an object of type uint8_t, uint16_t, uint32_t, uint64_t (exactly 8, 16, 32, 64)
(macro constant)
UINT_FAST8_WIDTH
UINT_FAST16_WIDTH
UINT_FAST32_WIDTH
UINT_FAST64_WIDTH
  
(C23)
 
bit width of an object of type uint_fast8_t, uint_fast16_t, uint_fast32_t, uint_fast64_t
(macro constant)
UINT_LEAST8_WIDTH
UINT_LEAST16_WIDTH
UINT_LEAST32_WIDTH
UINT_LEAST64_WIDTH
  
(C23)
 
bit width of an object of type uint_least8_t, uint_least16_t, uint_least32_t, uint_least64_t
(macro constant)
UINTPTR_WIDTH
  
(C23)(optional)
 
bit width of an object of type uintptr_t
(macro constant)
UINTMAX_WIDTH
  
(C23)
 
bit width of an object of type uintmax_t
(macro constant)
Unsigned integers : maximum value
UINT8_MAX
UINT16_MAX
UINT32_MAX
UINT64_MAX
 
maximum value of an object of type uint8_t, uint16_t, uint32_t, uint64_t
(macro constant)
UINT_FAST8_MAX
UINT_FAST16_MAX
UINT_FAST32_MAX
UINT_FAST64_MAX
 
maximum value of an object of type uint_fast8_t, uint_fast16_t, uint_fast32_t, uint_fast64_t
(macro constant)
UINT_LEAST8_MAX
UINT_LEAST16_MAX
UINT_LEAST32_MAX
UINT_LEAST64_MAX
 
maximum value of an object of type uint_least8_t, uint_least16_t, uint_least32_t, uint_least64_t
(macro constant)
UINTPTR_MAX
 
maximum value of an object of type uintptr_t
(macro constant)
UINTMAX_MAX
 
maximum value of an object of type uintmax_t
(macro constant)
Function macros for minimum-width integer constants
INT8_C
INT16_C
INT32_C
INT64_C
 
expands to an integer constant expression having the value specified by its argument and the type int_least8_t, int_least16_t, int_least32_t, int_least64_t respectively
(function macro)
INTMAX_C
 
expands to an integer constant expression having the value specified by its argument and the type intmax_t
(function macro)
UINT8_C
UINT16_C
UINT32_C
UINT64_C
 
expands to an integer constant expression having the value specified by its argument and the type uint_least8_t, uint_least16_t, uint_least32_t, uint_least64_t respectively
(function macro)
UINTMAX_C
 
expands to an integer constant expression having the value specified by its argument and the type uintmax_t
(function macro)
#include <stdint.h>
UINT64_C(0x123) // might expand to 0x123ULL or 0x123UL
