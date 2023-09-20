


/**
 * Portability Types
 * 
 * We never use core C-Types directly within C-Base. This gives us some assurances across systems but, 
 * also lets us get into more interesting things like Memory Management Systems and Algorithms later on by 
 * maintaining structural rigidity at the core. 
 * 
 * 
 */

#ifndef CBCORE_H
#define CBCORE_H

#include <stddef.h>

// typedef CBBoolean int;
// CBTrue
// CBFalse
typedef size_t CBSize;

//
// Ints
//

typedef void CBVoid;
typedef void* CBVoidPtr;

typedef int CBInteger;
typedef int* CBIntegerPtr;
typedef unsigned int CBUnsignedInteger;
typedef unsigned int* CBUnsignedIntegerPtr;

typedef short CBShort;
typedef short* CBShortPtr;
typedef unsigned short CBUnsignedShort;
typedef unsigned short* CBUnsignedShortPtr;

typedef long CBLong;
typedef long* CBLongPtr;
typedef unsigned long CBUnsignedLong;
typedef unsigned long* CBUnsignedLongPtr;

typedef float CBFloat;
typedef float* CBFloatPtr;

typedef double CBDouble;
typedef double* CBDoublePtr;

typedef char CBChar;
typedef char* CBCharPtr;
typedef unsigned char CBUnsignedChar;
typedef unsigned char* CBUnsignedCharPtr;

//////////////////////////
//
// SYNONYMS

typedef CBInteger CBBool;
#define CBTrue 1
#define CBFalse 0

typedef CBInteger CBInt;
typedef CBIntegerPtr CBIntPtr;

typedef CBUnsignedInteger CBUInteger;
typedef CBUnsignedInteger CBUInt;
typedef CBUnsignedIntegerPtr CBUIntegerPtr;
typedef CBUnsignedIntegerPtr CBUIntPtr;

typedef CBUnsignedShort CBUShort;
typedef CBUnsignedShortPtr CBUShortPtr;

typedef CBCharPtr CBString;
typedef CBString* CBStringArray;

// Primitive
// Pointer

// ByValue
// ByReference

#endif // CBCORE_H