

/*
Complex Number Type Definition and Operations 
*/

#ifndef CBMATH_CORE_H
#define CBMATH_CORE_H
#include "cbcore.h"

typedef struct _TCBComplex {
    CBInteger real;
    CBInteger imaginary; 
} CBComplex;


CBInteger CBMathMax(CBInteger val1, CBInteger val2);
CBInteger CBMathMin(CBInteger val1, CBInteger val2);

#endif // CBMATH_CORE_H