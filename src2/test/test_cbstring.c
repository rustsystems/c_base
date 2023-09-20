
#include <stdio.h>
#include <string.h>

#include "cbase.h"


// CBString CBNewString(CBChar strdata[]);
CBBool test_cbnewstring(int argc, char* argv[]) {
    CBString new_str = "mynewstr";
    CBInteger len = CBStringLength(new_str);
    // CBInteger newlength;

    // Contrive a char array to give that to newstr
    CBChar* basestr = CBStringToCharArray("mynewstr");
    CBString newString = CBNewString(basestr);   
}

// CBInteger CBStringLength(CBString str);
CBBool test_cbstringlength(int argc, char* argv[]) {}

// CBString CBStringConcatenate(CBString destination, CBString src);
CBBool test_cbstringconcatenate(int argc, char* argv[]) {}

// CBString CBStringConcatenateSome(CBString destination, CBString source, CBSize n);
CBBool test_cbstringconcatenatesome(int argc, char* argv[]) {}

// CBString CBStringSearchChar(const CBString string, CBInteger c);
CBBool test_cbstringsearchchar(int argc, char* argv[]) {}

// CBInteger CBStringCompare(const CBString string1, const CBString string2);
CBBool test_cbstringcompare(int argc, char* argv[]) {
    CBString str1 = "abcd"; 
    CBString str2 = "abCd";
    CBString str3 = "abcd";

    int result;

    // comparing strings str1 and str2
    result = CBStringCompare(str1, str2);
    printf("CBStringCompare(str1, str2) = %d\n", result);

    // comparing strings str1 and str3
    result = CBStringCompare(str1, str3);
    printf("CBStringCompare(str1, str3) = %d\n", result);
}

// CBInteger CBStringCompareSome(CBString string1, CBString string2, CBSize n);
CBBool test_cbstringcomparesome(int argc, char* argv[]) {}

// CBString CBStringCopy(CBString destination, CBString source);
CBBool test_cbstringcopy(int argc, char* argv[]) {
    printf("test_cbstringcopy\n");
    
    int size = sizeof "src_string";
    CBString destination;
    
    CBString source = "src_string";
    CBString result = CBStringCopy(destination, source);

    int cmp = strcmp(result, source);
    printf("cmp: %s \n", cmp);

    return 0;
}

// CBString CBStringCopySome(CBString destination, CBString source, CBSize n);
CBBool test_cbstringcopysome(int argc, char* argv[]) {}

// CBString CBStringSearchString(CBString haystack, CBString needle);
CBBool test_cbstringsearchstring(int argc, char* argv[]) {}

// CBString CBStringToLower(CBString string);
CBBool test_cbstringtolower(int argc, char* argv[]) {}

// CBString CBStringToUpper(CBString string);
CBBool test_cbstringtoupper(int argc, char* argv[]) {}

// CBString CBStringAsciiToInteger(CBString asciiString);
CBBool test_cbstringasciitointeger(int argc, char* argv[]) {
    int* ints = CBStringAsciiToInteger("1234");
}

// CBString CBStringIntegerToAscii(CBInteger intValue);
CBBool test_cbstringintegertoascii(int argc, char* argv[]) {}

// CBBool CBStringIsDigit(CBString string);
CBBool test_cbstringisdigit(int argc, char* argv[]) {}


int test_cbstring_main(int argc, char* argv[]) {
    test_cbnewstring(argc, argv);
    test_cbstringlength(argc, argv);

    test_cbstringconcatenate();

    CBBool result_cbstringcopy = test_cbstringcopy();
    printf("result_cbstringcopy: %d \n", result_cbstringcopy);
}


