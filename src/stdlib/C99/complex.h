Complex number arithmetic
 C Numerics Complex number arithmetic 
If the macro constant __STDC_NO_COMPLEX__ is defined by the implementation, the complex types, the header <complex.h> and all of the names listed here are not provided.

(since C11)
The C programming language, as of C99, supports complex number math with the three built-in types double _Complex, float _Complex, and long double _Complex (see _Complex). When the header <complex.h> is included, the three complex number types are also accessible as double complex, float complex, long double complex.

In addition to the complex types, the three imaginary types may be supported: double _Imaginary, float _Imaginary, and long double _Imaginary (see _Imaginary). When the header <complex.h> is included, the three imaginary types are also accessible as double imaginary, float imaginary, and long double imaginary.

Standard arithmetic operators +, -, *, / can be used with real, complex, and imaginary types in any combination.

A compiler that defines __STDC_IEC_559_COMPLEX__ is recommended, but not required to support imaginary numbers. POSIX recommends checking if the macro _Imaginary_I is defined to identify imaginary number support.

(since C99)
(until C11)
Imaginary numbers are supported if __STDC_IEC_559_COMPLEX__ or __STDC_IEC_60559_COMPLEX__ (since C23) is defined.

(since C11)
Defined in header <complex.h>
Types
imaginary
  
(C99)
 
imaginary type macro
(keyword macro)
complex
  
(C99)
 
complex type macro
(keyword macro)
The imaginary constant
_Imaginary_I
  
(C99)
 
the imaginary unit constant i
(macro constant)
_Complex_I
  
(C99)
 
the complex unit constant i
(macro constant)
I
  
(C99)
 
the complex or imaginary unit constant i
(macro constant)
Manipulation
CMPLX
CMPLXF
CMPLXL
  
(C11)
(C11)
(C11)
 
constructs a complex number from real and imaginary parts
(function macro)
creal
crealf
creall
  
(C99)
(C99)
(C99)
 
computes the real part of a complex number
(function)
cimag
cimagf
cimagl
  
(C99)
(C99)
(C99)
 
computes the imaginary part a complex number
(function)
cabs
cabsf
cabsl
  
(C99)
(C99)
(C99)
 
computes the magnitude of a complex number
(function)
carg
cargf
cargl
  
(C99)
(C99)
(C99)
 
computes the phase angle of a complex number
(function)
conj
conjf
conjl
  
(C99)
(C99)
(C99)
 
computes the complex conjugate
(function)
cproj
cprojf
cprojl
  
(C99)
(C99)
(C99)
 
computes the projection on Riemann sphere
(function)
Exponential functions
cexp
cexpf
cexpl
  
(C99)
(C99)
(C99)
 
computes the complex base-e exponential
(function)
clog
clogf
clogl
  
(C99)
(C99)
(C99)
 
computes the complex natural logarithm
(function)
Power functions
cpow
cpowf
cpowl
  
(C99)
(C99)
(C99)
 
computes the complex power function
(function)
csqrt
csqrtf
csqrtl
  
(C99)
(C99)
(C99)
 
computes the complex square root
(function)
Trigonometric functions
csin
csinf
csinl
  
(C99)
(C99)
(C99)
 
computes the complex sine
(function)
ccos
ccosf
ccosl
  
(C99)
(C99)
(C99)
 
computes the complex cosine
(function)
ctan
ctanf
ctanl
  
(C99)
(C99)
(C99)
 
computes the complex tangent
(function)
casin
casinf
casinl
  
(C99)
(C99)
(C99)
 
computes the complex arc sine
(function)
cacos
cacosf
cacosl
  
(C99)
(C99)
(C99)
 
computes the complex arc cosine
(function)
catan
catanf
catanl
  
(C99)
(C99)
(C99)
 
computes the complex arc tangent
(function)
Hyperbolic functions
csinh
csinhf
csinhl
  
(C99)
(C99)
(C99)
 
computes the complex hyperbolic sine
(function)
ccosh
ccoshf
ccoshl
  
(C99)
(C99)
(C99)
 
computes the complex hyperbolic cosine
(function)
ctanh
ctanhf
ctanhl
  
(C99)
(C99)
(C99)
 
computes the complex hyperbolic tangent
(function)
casinh
casinhf
casinhl
  
(C99)
(C99)
(C99)
 
computes the complex arc hyperbolic sine
(function)
cacosh
cacoshf
cacoshl
  
(C99)
(C99)
(C99)
 
computes the complex arc hyperbolic cosine
(function)
catanh
catanhf
catanhl
  
(C99)
(C99)
(C99)
 
computes the complex arc hyperbolic tangent
(function)
Notes
The following function names are potentially (since C23) reserved for future addition to complex.h and are not available for use in the programs that include that header: cerf, cerfc, cexp2, cexpm1, clog10, clog1p, clog2, clgamma, ctgamma, csinpi, ccospi, ctanpi, casinpi, cacospi, catanpi, ccompoundn, cpown, cpowr, crootn, crsqrt, cexp10m1, cexp10, cexp2m1, clog10p1, clog2p1, clogp1 (since C23), along with their -f and -l suffixed variants.

Although the C standard names the inverse hyperbolics with "complex arc hyperbolic sine" etc., the inverse functions of the hyperbolic functions are the area functions. Their argument is the area of a hyperbolic sector, not an arc. The correct names are "complex inverse hyperbolic sine" etc. Some authors use "complex area hyperbolic sine" etc.

A complex or imaginary number is infinite if one of its parts is infinite, even if the other part is NaN.

A complex or imaginary number is finite if both parts are neither infinities nor NaNs.

A complex or imaginary number is a zero if both parts are positive or negative zeroes.

Example
Run this code
#include <stdio.h>
#include <complex.h>
#include <tgmath.h>
 
int main(void)
{
    double complex z1 = I * I;     // imaginary unit squared
    printf("I * I = %.1f%+.1fi\n", creal(z1), cimag(z1));
 
    double complex z2 = pow(I, 2); // imaginary unit squared
    printf("pow(I, 2) = %.1f%+.1fi\n", creal(z2), cimag(z2));
 
    double PI = acos(-1);
    double complex z3 = exp(I * PI); // Euler's formula
    printf("exp(I*PI) = %.1f%+.1fi\n", creal(z3), cimag(z3));
 
    double complex z4 = 1+2*I, z5 = 1-2*I; // conjugates
    printf("(1+2i)*(1-2i) = %.1f%+.1fi\n", creal(z4*z5), cimag(z4*z5));
}
Output:

I * I = -1.0+0.0i
pow(I, 2) = -1.0+0.0i
exp(I*PI) = -1.0+0.0i
(1+2i)*(1-2i) = 5.0+0.0i