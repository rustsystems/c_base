Format macro constants
Defined in header <inttypes.h>
Format constants for the fprintf family of functions
Each of the PRI macros listed here is defined if and only if the implementation defines the corresponding typedef name.

Equivalent
for int or
unsigned int	Description	Macros for data types




[u]intx_t




[u]int_leastx_t
[u]int_fastx_t
[u]intmax_t
[u]intptr_t
d	output of a signed decimal integer value	PRIdx	PRIdLEASTx	PRIdFASTx	PRIdMAX	PRIdPTR
i	PRIix	PRIiLEASTx	PRIiFASTx	PRIiMAX	PRIiPTR
u	output of an unsigned decimal integer value	PRIux	PRIuLEASTx	PRIuFASTx	PRIuMAX	PRIuPTR
o	output of an unsigned octal integer value	PRIox	PRIoLEASTx	PRIoFASTx	PRIoMAX	PRIoPTR
x	output of an unsigned lowercase hexadecimal integer value	PRIxx	PRIxLEASTx	PRIxFASTx	PRIxMAX	PRIxPTR
X	output of an unsigned uppercase hexadecimal integer value	PRIXx	PRIXLEASTx	PRIXFASTx	PRIXMAX	PRIXPTR
Format constants for the fscanf family of functions
Each of the SCN macros listed in here is defined if and only if the implementation defines the corresponding typedef name and has a suitable fscanf length modifier for the type.

Equivalent
for int or
unsigned int	Description	Macros for data types




[u]intx_t




[u]int_leastx_t
[u]int_fastx_t
[u]intmax_t
[u]intptr_t
d	input of a signed decimal integer value	SCNdx	SCNdLEASTx	SCNdFASTx	SCNdMAX	SCNdPTR
i	input of a signed integer value (base is determined by the first characters parsed)	SCNix	SCNiLEASTx	SCNiFASTx	SCNiMAX	SCNiPTR
u	input of an unsigned decimal integer value	SCNux	SCNuLEASTx	SCNuFASTx	SCNuMAX	SCNuPTR
o	input of an unsigned octal integer value	SCNox	SCNoLEASTx	SCNoFASTx	SCNoMAX	SCNoPTR
x	input of an unsigned hexadecimal integer value	SCNxx	SCNxLEASTx	SCNxFASTx	SCNxMAX	SCNxPTR
Example
Run this code
#include <inttypes.h>
#include <stdio.h>
 
int main(void)
{
    printf("%zu\n", sizeof(int64_t));
    printf("%s\n", PRId64);
    printf("%+"PRId64"\n", INT64_MIN);
    printf("%+"PRId64"\n", INT64_MAX);
 
    int64_t n = 7;
    printf("%+"PRId64"\n", n);
}
Possible output:

8
lld
-9223372036854775808
+9223372036854775807
+7
References
C23 standard (ISO/IEC 9899:2023):
7.8.1 Macros for format specifiers (p: TBD)
7.18 Integer types <stdint.h> (p: TBD)
C17 standard (ISO/IEC 9899:2018):
7.8.1 Macros for format specifiers (p: 158-159)
7.18 Integer types <stdint.h> (p: 212-216)
C11 standard (ISO/IEC 9899:2011):
7.8.1 Macros for format specifiers (p: 217-218)
7.18 Integer types <stdint.h> (p: 289-295)
C99 standard (ISO/IEC 9899:1999):
7.8.1 Macros for format specifiers (p: 198-199)
7.18 Integer types <stdint.h> (p: 255-261)
