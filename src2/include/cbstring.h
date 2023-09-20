
#ifndef CBSTRING_H
#define CBSTRING_H

#include "cbcore.h"


/*
 * Allocates the length of the Array plus 1 for the char-data and returns a pointer to it in the form of a string.
 */
CBString CBNewString(CBChar strdata[]);


CBCharPtr CBStringToCharArray(CBString str);


CBInteger CBStringLength(CBString str);


// char *strcat(char *dest, const char *src)
// Appends the string pointed to, by src to the end of the string pointed to by dest.
CBString CBStringConcatenate(CBString destination, CBString src);


// char *strncat(char *dest, const char *src, size_t n)
// Appends the string pointed to, by src to the end of the string pointed to, by dest up to n characters long.
CBString CBStringConcatenateSome(CBString destination, CBString source, CBSize n);


// char *strchr(const char *str, int c)
// Searches for the first occurrence of the character c (an unsigned char) in the string pointed to, by the argument str.
CBString CBStringSearchChar(const CBString str, CBUnsignedChar c);

 
// Compares the string pointed to, by str1 to the string pointed to by str2.
// int strcmp(const char *str1, const char *str2)
CBInteger CBStringCompare(const CBString string1, const CBString string2);


// int strncmp(const char *str1, const char *str2, size_t n)
// Compares at most the first n bytes of str1 and str2.
CBInteger CBStringCompareSome(CBString string1, CBString string2, CBSize n);


// char *strcpy(char *dest, const char *src)
// Copies the string pointed to, by src to dest.
CBString CBStringCopy(CBString destination, CBString source);


// char *strncpy(char *dest, const char *src, size_t n)
// Copies up to n characters from the string pointed to, by src to dest.
CBString CBStringCopySome(CBString destination, CBString source, CBSize n);


//============================================================================= 
// Finds the first occurrence of the entire string needle (not including the 
// terminating null character) which appears in the string haystack.
//
// Synopsis:
//     1 #include <string.h>
//         char *strstr(const char *s1, const char *s2);
// Description:
//     2 The strstr function locates the first occurrence in the string
//       pointed to by s1 of the sequence of characters (excluding the terminating
//       null character) in the string pointed to by s2.
// Returns:
//     3 The strstr function returns a pointer to the located string, or a null 
//       pointer if the string is not found. If s2 points to a string with zero 
//       length, the function returns s
//
// char *strstr(const char *haystack, const char *needle);
//
CBString CBStringSearchString(CBString haystack, CBString needle);


// 
CBString CBStringToLower(CBString string);
CBString CBStringToUpper(CBString string);

CBString CBStringAsciiToInteger(CBString asciiString);
CBString CBStringIntegerToAscii(CBInteger intValue);

CBString CBStringReverse(CBString str);
CBBool CBStringIsDigit(CBString string);
CBBool CBStringIsWhitespace(CBString string);



CBString CBStringStrip(CBString str);
CBString CBStringLeftStrip(CBString str);
CBString CBStringRightStrip(CBString str);
CBString CBStringRemovePrefix(CBString str, CBString prefix);
CBString CBStringRemoveSuffix(CBString str, CBString suffix);
CBStringArray CBStringSplit(CBString str, CBChar splitChar);
CBStringArray CBStringSplitLines(CBString str);
CBBool CBStringStartsWith(CBString str, CBString startingSequence);





// Python Inspired Slice Operations:

// 3.2.13.4. Slice objects
// Slice objects are used to represent slices for __getitem__() methods. They are 
// also created by the built-in slice() function.

// Special read-only attributes: start is the lower bound; stop is the upper bound; 
// step is the step value; each is None if omitted. These attributes can have any type.

// Slice objects support one method:

// slice.indices(self, length)
// This method takes a single integer argument length and computes information about the slice that the 
// slice object would describe if applied to a sequence of length items. It returns a tuple of three integers; 
// respectively these are the start and stop indices and the step or stride length of the slice. Missing or 
// out-of-bounds indices are handled in a manner consistent with regular slices.

























// Library Functions
// Following are the functions defined in the header string.h −

// Sr.No.	Function & Description
// 1	void *memchr(const void *str, int c, size_t n)
// Searches for the first occurrence of the character c (an unsigned char) in the first n bytes of the string pointed to, by the argument str.

// 2	int memcmp(const void *str1, const void *str2, size_t n)
// Compares the first n bytes of str1 and str2.

// 3	void *memcpy(void *dest, const void *src, size_t n)
// Copies n characters from src to dest.

// 4	void *memmove(void *dest, const void *src, size_t n)
// Another function to copy n characters from str2 to str1.

// 5	void *memset(void *str, int c, size_t n)
// Copies the character c (an unsigned char) to the first n characters of the string pointed to, by the argument str.





// 11	int strcoll(const char *str1, const char *str2)
// Compares string str1 to str2. The result is dependent on the LC_COLLATE setting of the location.




// 14	size_t strcspn(const char *str1, const char *str2)
// Calculates the length of the initial segment of str1 which consists entirely of characters not in str2.

// 15	char *strerror(int errnum)
// Searches an internal array for the error number errnum and returns a pointer to an error message string.

// 16	size_t strlen(const char *str)
// Computes the length of the string str up to but not including the terminating null character.

// 17	char *strpbrk(const char *str1, const char *str2)
// Finds the first character in the string str1 that matches any character specified in str2.

// 18	char *strrchr(const char *str, int c)
// Searches for the last occurrence of the character c (an unsigned char) in the string pointed to by the argument str.

// 19	size_t strspn(const char *str1, const char *str2)
// Calculates the length of the initial segment of str1 which consists entirely of characters in str2.


// 21	char *strtok(char *str, const char *delim)
// Breaks string str into a series of tokens separated by delim.

// 22	size_t strxfrm(char *dest, const char *src, size_t n)
// Transforms the first n characters of the string src into current locale and places them in the string dest.


#endif // CBSTRING_H