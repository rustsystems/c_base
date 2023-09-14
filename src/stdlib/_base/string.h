
/**
 * C-Base (CB) Implementation of string.h
 *
 * (C) 2023, Rust Systems, Inc. and Brian C. Abbott.
 */


/* 
===============================================================================
Copying: 
===============================================================================
*/


/* 
 * Copy a block of memory
 * Copies the values of num bytes from the location pointed to by source 
 * directly to the memory block pointed to by destination.
 * 
 * The underlying type of the objects pointed to by both the source and 
 * destination pointers are irrelevant for this function; The result is 
 * a binary copy of the data.
 * 
 * The function does not check for any terminating null character in 
 * source - it always copies exactly num bytes.
 * 
 * To avoid overflows, the size of the arrays pointed to by both the 
 * destination and source parameters, shall be at least num bytes, 
 * and should not overlap (for overlapping memory blocks, memmove is 
 * a safer approach).
 * 
 * Parameters:
 *    - destination:  Pointer to the destination array where the content 
 *                    is to be copied, type-casted to a pointer of type 
 *                    void*.
 *
 *    - source:       Pointer to the source of data to be copied, 
 *                    type-casted to a pointer of type const void*.
 *
 *    - num:          Number of bytes to copy. size_t is an 
 *                    unsigned integral type.
 * 
 * Return Value:
 *    - destination is returned.
 *
 * C-Signature:
 *    'void* memcpy(void* destination, const void* source, size_t num);'
 */
void* CBMemoryCopy(void* destination, const void* source, CBSize_T num);






// memmove	Move block of memory (function)
/* 
 * Move block of memory
 * Copies the values of num bytes from the location pointed by source to the 
 * memory block pointed by destination. Copying takes place as if an intermediate 
 * buffer were used, allowing the destination and source to overlap.
 * 
 * The underlying type of the objects pointed by both the source and destination 
 * pointers are irrelevant for this function; The result is a binary copy of the 
 * data.
 * 
 * The function does not check for any terminating null character in source - it 
 * always copies exactly num bytes.
 * 
 * To avoid overflows, the size of the arrays pointed by both the destination and 
 * source parameters, shall be at least num bytes.
 * 
 * Parameters:
 *    - destination:    Pointer to the destination array where the content is to 
 *                      be copied, type-casted to a pointer of type void*.
 * 
 *    - source:         Pointer to the source of data to be copied, type-casted 
 *                      to a pointer of type const void*.
 * 
 *    - num:            Number of bytes to copy. size_t is an 
 *                      unsigned integral type.
 * 
 * Return Value: 
 *    - destination is returned.
 * 
 * C-Signature:
 *    'void * memmove ( void * destination, const void * source, size_t num );'
 */
void* CBMemoryMove(void* destination, const void* source, CBSize_T num);

/*
 * Copy string
 * Copies the C string pointed by source into the array pointed by destination, 
 * including the terminating null character (and stopping at that point).
 * 
 * To avoid overflows, the size of the array pointed by destination shall be 
 * long enough to contain the same C string as source (including the 
 * terminating null character), and should not overlap in memory with source.
 * 
 * Parameters:
 *    - destination:    Pointer to the destination array where the content is 
 *                      to be copied.
 *
 *    - source:         C string to be copied.
 * 
 * Return Value:
 *    - destination is returned.
 * 
 * C-Signature:
 *    'char * strcpy ( char * destination, const char * source );'
 */
char* CBStringCopy(char* destination, const char* source);

/*
 * Copy characters from string
 * Copies the first num characters of source to destination. If the end of the 
 * source C string (which is signaled by a null-character) is found before num 
 * characters have been copied, destination is padded with zeros until a total 
 * of num characters have been written to it.
 * 
 * No null-character is implicitly appended at the end of destination if source 
 * is longer than num. Thus, in this case, destination shall not be considered 
 * a null terminated C string (reading it as such would overflow).
 * 
 * destination and source shall not overlap (see memmove for a safer 
 * alternative when overlapping).
 * 
 * Parameters:
 *    - destination:    Pointer to the destination array where the content is 
 *                      to be copied.
 *
 *    - source:         C string to be copied.
 *
 *    - num:            Maximum number of characters to be copied from source. 
 *                      size_t is an unsigned integral type.
 * 
 * Return Value:
 *    - destination is returned.
 *
 * C-Signature:
 *   'char * strncpy ( char * destination, const char * source, size_t num );'
 */
char* CBStringNCopy(char* destination, const char* source, CBSize_T num)

/* Concatenation: */ 

strcat	Concatenate strings (function)
CBStringConcatenate()

strncat	Append characters from string (function)
CBStringNConcatenate()

/* Comparison: */

memcmp	Compare two blocks of memory (function)
CBMemoryCompare()

strcmp	Compare two strings (function)
StringCompare()

strcoll	Compare two strings using locale (function)
StringCollate()

strncmp	Compare characters of two strings (function)
StringNCompare()

strxfrm	Transform string using locale (function)
String
/* Searching: */ 

memchr	Locate character in block of memory (function)
strchr	Locate first occurrence of character in string (function)
strcspn	Get span until character in string (function)
strpbrk	Locate characters in string (function)
strrchr	Locate last occurrence of character in string (function)
strspn	Get span of character set in string (function)
strstr	Locate substring (function)
strtok	Split string into tokens (function)

/* Other: */

memset	Fill block of memory (function)
strerror	Get pointer to error message string (function)
strlen	Get string length (function)

/* Macros */
NULL	Null pointer (macro)

/* Types */ 
size_t	Unsigned integral type (type)
/*
 * Return the lenth (len) of a given string minus the length of the terminating control character.
 * equiv: strlen()
 */
int CBStringLength(char* str);

/*
 * Copy one string, str b into another string, str a (b is copied onto a).
 * equiv: strcpy()
 */
void CBStringCopy(char* str_a, char* str_b);