Defined in header <math.h>
Basic operations
fabs
fabsf
fabsl
  
(C99)
(C99)
 
computes absolute value of a floating-point value (
|
x
|
)
(function)
fmod
fmodf
fmodl
  
(C99)
(C99)
 
computes remainder of the floating-point division operation
(function)
remainder
remainderf
remainderl
  
(C99)
(C99)
(C99)
 
computes signed remainder of the floating-point division operation
(function)
remquo
remquof
remquol
  
(C99)
(C99)
(C99)
 
computes signed remainder as well as the three last bits of the division operation
(function)
fma
fmaf
fmal
  
(C99)
(C99)
(C99)
 
computes fused multiply-add operation
(function)
fmax
fmaxf
fmaxl
  
(C99)
(C99)
(C99)
 
determines larger of two floating-point values
(function)
fmin
fminf
fminl
  
(C99)
(C99)
(C99)
 
determines smaller of two floating-point values
(function)
fdim
fdimf
fdiml
  
(C99)
(C99)
(C99)
 
determines positive difference of two floating-point values (
max
(
0
,
x
−
y
)
)
(function)
nan
nanf
nanl
  
(C99)
(C99)
(C99)
 
returns a NaN (not-a-number)
(function)
Exponential functions
exp
expf
expl
  
(C99)
(C99)
 
computes e raised to the given power (
e
x
)
(function)
exp2
exp2f
exp2l
  
(C99)
(C99)
(C99)
 
computes 2 raised to the given power (
2
x
)
(function)
expm1
expm1f
expm1l
  
(C99)
(C99)
(C99)
 
computes e raised to the given power, minus one (
e
x
−
1
)
(function)
log
logf
logl
  
(C99)
(C99)
 
computes natural (base-e) logarithm (
ln
x
)
(function)
log10
log10f
log10l
  
(C99)
(C99)
 
computes common (base-10) logarithm (
log
10
x
)
(function)
log2
log2f
log2l
  
(C99)
(C99)
(C99)
 
computes base-2 logarithm (
log
2
x
)
(function)
log1p
log1pf
log1pl
  
(C99)
(C99)
(C99)
 
computes natural (base-e) logarithm of 1 plus the given number (
ln
(
1
+
x
)
)
(function)
Power functions
pow
powf
powl
  
(C99)
(C99)
 
computes a number raised to the given power (
x
y
)
(function)
sqrt
sqrtf
sqrtl
  
(C99)
(C99)
 
computes square root (
√
x
)
(function)
cbrt
cbrtf
cbrtl
  
(C99)
(C99)
(C99)
 
computes cube root (
3
√
x
)
(function)
hypot
hypotf
hypotl
  
(C99)
(C99)
(C99)
 
computes square root of the sum of the squares of two given numbers (
√
x
2
+
y
2
)
(function)
Trigonometric functions
sin
sinf
sinl
  
(C99)
(C99)
 
computes sine (
sin
x
)
(function)
cos
cosf
cosl
  
(C99)
(C99)
 
computes cosine (
cos
x
)
(function)
tan
tanf
tanl
  
(C99)
(C99)
 
computes tangent (
tan
x
)
(function)
asin
asinf
asinl
  
(C99)
(C99)
 
computes arc sine (
arcsin
x
)
(function)
acos
acosf
acosl
  
(C99)
(C99)
 
computes arc cosine (
arccos
x
)
(function)
atan
atanf
atanl
  
(C99)
(C99)
 
computes arc tangent (
arctan
x
)
(function)
atan2
atan2f
atan2l
  
(C99)
(C99)
 
computes arc tangent, using signs to determine quadrants
(function)
Hyperbolic functions
sinh
sinhf
sinhl
  
(C99)
(C99)
 
computes hyperbolic sine (
sinh
x
)
(function)
cosh
coshf
coshl
  
(C99)
(C99)
 
computes hyperbolic cosine (
cosh
x
)
(function)
tanh
tanhf
tanhl
  
(C99)
(C99)
 
computes hyperbolic tangent (
tanh
x
)
(function)
asinh
asinhf
asinhl
  
(C99)
(C99)
(C99)
 
computes inverse hyperbolic sine (
arsinh
x
)
(function)
acosh
acoshf
acoshl
  
(C99)
(C99)
(C99)
 
computes inverse hyperbolic cosine (
arcosh
x
)
(function)
atanh
atanhf
atanhl
  
(C99)
(C99)
(C99)
 
computes inverse hyperbolic tangent (
artanh
x
)
(function)
Error and gamma functions
erf
erff
erfl
  
(C99)
(C99)
(C99)
 
computes error function
(function)
erfc
erfcf
erfcl
  
(C99)
(C99)
(C99)
 
computes complementary error function
(function)
tgamma
tgammaf
tgammal
  
(C99)
(C99)
(C99)
 
computes gamma function
(function)
lgamma
lgammaf
lgammal
  
(C99)
(C99)
(C99)
 
computes natural (base-e) logarithm of the gamma function
(function)
Nearest integer floating-point operations
ceil
ceilf
ceill
  
(C99)
(C99)
 
computes smallest integer not less than the given value
(function)
floor
floorf
floorl
  
(C99)
(C99)
 
computes largest integer not greater than the given value
(function)
trunc
truncf
truncl
  
(C99)
(C99)
(C99)
 
rounds to nearest integer not greater in magnitude than the given value
(function)
round
roundf
roundl
lround
lroundf
lroundl
llround
llroundf
llroundl
  
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
 
rounds to nearest integer, rounding away from zero in halfway cases
(function)
nearbyint
nearbyintf
nearbyintl
  
(C99)
(C99)
(C99)
 
rounds to an integer using current rounding mode
(function)
rint
rintf
rintl
lrint
lrintf
lrintl
llrint
llrintf
llrintl
  
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
 
rounds to an integer using current rounding mode with
exception if the result differs
(function)
Floating-point manipulation functions
frexp
frexpf
frexpl
  
(C99)
(C99)
 
breaks a number into significand and a power of 2
(function)
ldexp
ldexpf
ldexpl
  
(C99)
(C99)
 
multiplies a number by 2 raised to a power
(function)
modf
modff
modfl
  
(C99)
(C99)
 
breaks a number into integer and fractional parts
(function)
scalbn
scalbnf
scalbnl
scalbln
scalblnf
scalblnl
  
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
 
computes efficiently a number times FLT_RADIX raised to a power
(function)
ilogb
ilogbf
ilogbl
  
(C99)
(C99)
(C99)
 
extracts exponent of the given number
(function)
logb
logbf
logbl
  
(C99)
(C99)
(C99)
 
extracts exponent of the given number
(function)
nextafter
nextafterf
nextafterl
nexttoward
nexttowardf
nexttowardl
  
(C99)
(C99)
(C99)
(C99)
(C99)
(C99)
 
determines next representable floating-point value towards the given value
(function)
copysign
copysignf
copysignl
  
(C99)
(C99)
(C99)
 
produces a value with the magnitude of a given value and the sign of another given value
(function)
Classification and comparison
fpclassify
  
(C99)
 
classifies the given floating-point value
(function macro)
isfinite
  
(C99)
 
checks if the given number has finite value
(function macro)
isinf
  
(C99)
 
checks if the given number is infinite
(function macro)
isnan
  
(C99)
 
checks if the given number is NaN
(function macro)
isnormal
  
(C99)
 
checks if the given number is normal
(function macro)
signbit
  
(C99)
 
checks if the given number is negative
(function macro)
isgreater
  
(C99)
 
checks if the first floating-point argument is greater than the second
(function macro)
isgreaterequal
  
(C99)
 
checks if the first floating-point argument is greater or equal than the second
(function macro)
isless
  
(C99)
 
checks if the first floating-point argument is less than the second
(function macro)
islessequal
  
(C99)
 
checks if the first floating-point argument is less or equal than the second
(function macro)
islessgreater
  
(C99)
 
checks if the first floating-point argument is less or greater than the second
(function macro)
isunordered
  
(C99)
 
checks if two floating-point values are unordered
(function macro)
Types
Defined in header <stdlib.h>
div_t
 
structure type, return of the div function
(typedef)
ldiv_t
 
structure type, return of the ldiv function
(typedef)
lldiv_t
  
(C99)
 
structure type, return of the lldiv function
(typedef)
Defined in header <inttypes.h>
imaxdiv_t
  
(C99)
 
structure type, return of the imaxdiv function
(typedef)
Defined in header <math.h>
float_t
double_t
  
(C99)
(C99)
 
most efficient floating-point type at least as wide as float or double
(typedef)
Macro constants
Defined in header <math.h>
HUGE_VALF
HUGE_VAL
HUGE_VALL
  
(C99)
(C99)
 
indicates value too big to be representable (infinity) by float, double and long double respectively
(macro constant)
INFINITY
  
(C99)
 
evaluates to positive infinity or the value guaranteed to overflow a float
(macro constant)
NAN
  
(C99)
 
evaluates to a quiet NaN of type float
(macro constant)
FP_FAST_FMAF
FP_FAST_FMA
FP_FAST_FMAL
  
(C99)
(C99)
(C99)
 
indicates that the fma function generally executes about as fast as, or faster than, a multiply and an add of double operands
(macro constant)
FP_ILOGB0
FP_ILOGBNAN
  
(C99)
(C99)
 
evaluates to ilogb(x) if x is zero or NaN, respectively
(macro constant)
math_errhandling
MATH_ERRNO
MATH_ERREXCEPT
  
(C99)
(C99)
(C99)
 
defines the error handling mechanism used by the common mathematical functions
(macro constant)
Classification
FP_NORMAL
FP_SUBNORMAL
FP_ZERO
FP_INFINITE
FP_NAN
  
(C99)
(C99)
(C99)
(C99)
(C99)
 
indicates a floating-point category
(macro constant)
References
C17 standard (ISO/IEC 9899:2018):
7.8 Format conversion of integer types <inttypes.h> (p: 158-160)
7.12 Mathematics <math.h> (p: 169-190)
7.22 General utilities <stdlib.h> (p: 248-262)
7.31.5 Format conversion of integer types <inttypes.h> (p: 332)
7.31.12 General utilities <stdlib.h> (p: 333)
C11 standard (ISO/IEC 9899:2011):
7.8 Format conversion of integer types <inttypes.h> (p: 217-220)
7.12 Mathematics <math.h> (p: 231-261)
7.22 General utilities <stdlib.h> (p: 340-360)
7.31.5 Format conversion of integer types <inttypes.h> (p: 455)
7.31.12 General utilities <stdlib.h> (p: 456)
C99 standard (ISO/IEC 9899:1999):
7.8 Format conversion of integer types <inttypes.h> (p: 198-201)
7.12 Mathematics <math.h> (p: 212-242)
7.20 General utilities <stdlib.h> (p: 306-324)
7.26.4 Format conversion of integer types <inttypes.h> (p: 401)
7.26.10 General utilities <stdlib.h> (p: 402)
C89/C90 standard (ISO/IEC 9899:1990):
4.5 MATHEMATICS <math.h>
4.10 GENERAL UTILITIES <stdlib.h>
4.13.4 Mathematics <math.h>
7.13.7 General utilities <stdlib.h>