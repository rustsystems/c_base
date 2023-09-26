

#include <string.h>
#include <stdio.h>

#include "cbase.h"
#include "cbcconsts.h"





CBString CBNewString(CBChar strdata[]) {
    CBInteger strlen = sizeof strdata + 1;
    CBVoidPtr memspace = Allocate(sizeof strdata + 1); 
    CBString newstr = CBStringCopy((CBString)memspace, (CBString)strdata);
    newstr[strlen -1] = '\0';
    return newstr;    
}


CBCharPtr CBStringToCharArray(CBString str) {
    CBInteger strlen = CBStringLength(str) - 1;
    char chrarr[strlen];
    for (int i = 0; i < strlen; i++) {
        chrarr[i] = str[i];
    }
    return chrarr;
}


CBInteger CBStringLength(CBString str) {
    CBInteger i = 0; 
    while (str[i] != '\0') {
        i += 1;
    }
    return i;
}


CBString CBStringConcatenateSome(CBString dest, CBString src, CBSize n) {
    CBInteger destlen = CBStringLength(dest) - 1;
    // CBInteger srclen = CBStringLength(src) - 1;
    
    CBInteger newlen = destlen + n + 1;
    CBString newspace = Allocate(newlen);
    CBInteger i = 0;
    for (; i < newlen; i++) {
        if (i < destlen) {
            newspace[i] = dest[i];
        } else if (i > destlen && i < newlen) {
            newspace[i] = src[i - destlen];
        }
    }
    newspace[newlen - 1] = '\0';
    
    return newspace;
}


CBString CBStringConcatenate(CBString dest, CBString src) {
    CBInteger srclen = CBStringLength(src) - 1;
    return CBStringConcatenateSome(dest, src, srclen);
}


CBString CBStringSearchChar(const CBString str, CBUnsignedChar c) {
    int i = 0;
    CBBool found = CBFalse;
    CBInteger strlen = CBStringLength(str);
    for (int i = 0; i < strlen; i++) {
        if (str[i] == c) {
            found = CBTrue;
            break;
        }
    }
    if (found) {
        return str + i;
    } else {
        return CBNull;
    }
}


CBInteger CBStringCompare(const CBString string1, const CBString string2) {
    CBInteger strlen1 = CBStringLength(string1);
    CBInteger strlen2 = CBStringLength(string2);
    CBInteger maxlen = CBMathMax(strlen1, strlen2);

    CBInteger retval;
    if (strlen1 == strlen2) {
        for (int i = 0; i < maxlen; i++) {
            if (string1[i] != string2[i]) {
                return string1[i] - string2[i];
            }
        }
        return 0;
    } else {
        CBInteger lendiff = CBMathMax(strlen1, strlen2) - CBMathMin(strlen1, strlen2);
        if (strlen1 > strlen2) {
            return string1[strlen1 - lendiff] - string2[strlen2];
        } else {
            return string1[strlen1] - string2[strlen2 - lendiff];
        }
    }
}


CBInteger CBStringCompareSome(CBString string1, CBString string2, CBSize n) {
    CBInteger strlen1 = CBStringLength(string1);
    CBInteger strlen2 = CBStringLength(string2);
    CBInteger maxlen = CBMathMax(strlen1, strlen2);

    if (n > maxlen) {
        return -1;
    }
    for (int i = 0; i < n; i++) {
        if (string1[i] != string2[i]) {
            return string1[i] - string2[i];
        }
    }
    return 0;
}


CBString CBStringCopy(CBString destination, CBString source) {
    CBInteger src_length = CBStringLength(source);
    destination = (CBString)Allocate(src_length + 1);    
    for (int i = 0; i < src_length; i++) {
        destination[i] = source[i];
    }
    destination[src_length] = '\0';
    return destination;
}


CBString CBStringCopySome(CBString destination, CBString source, CBSize n) {    
    destination = (CBString)Allocate(src_length + 1);    
    for (int i = 0; i < n; i++) {
        destination[i] = source[i];
    }
    destination[src_length] = '\0';
    return destination;
}


CBString CBStringSearchString(CBString haystack, CBString needle) {
    CBInteger haylength = CBStringLength(haystack);
    CBInteger needle_length = CBStringLength(needle);

    for (int i = 0; i < haylength; i++) {
        for (int j = 0; j < needle_length; j++) {
            if (haystack[i] == needle[j]) {
                continue;
            } else {
                if (j == needle_length - 1) {
                    return &haystack[i];
                }
            }
        }
    }
    
    return CBNull;
}


CBString CBStringToLower(CBString str) {
    CBInteger strlen = CBStringLength(str);
    CBString lowered[strlen + 1];
    for (int i = 0; i < strlen; i++) {
        if (str[i] == AlphaToLower[i][0]) {
            lowered = CBStringConcatenate(lowered, AlphaToLower[i][1]);
        }
    }

    return lowered;
}


CBString CBStringToUpper(CBString lower) {
    CBInteger strlen = CBStringLength(lower);
    CBString upper[strlen + 1];
    for (int i = 0; i < strlen; i++) {
        if (lower[i] == AlphaToUpper[i][0]) {
            upper = CBStringConcatenate(upper, AlphaToUpper[i][1]);
        }
    }
    return upper;
}


CBInteger* CBStringAsciiToInteger(CBString asciiString) {
    CBInteger strlen = CBStringLength(asciiString);
    CBInteger* intarr[strlen];
    for (int i = 0; i < sizeof(AsciiToInteger); i++) {
        for (int i = 0; i < sizeof(AsciiToInteger); i++) {
            if (asciiString[i] == AsciiToInteger[i][0]) {
                *intarr++ = AsciiToInteger[i][1];
            }
        }
    }
    return intarr;
}

CBString CBStringIntegerToAscii(CBInteger intValue) {
    IntegerToAscii[intValue];
}


CBBool CBStringIsDigit(CBString string) {
    
    return CBTrue;
}

CBBool CBStringIsWhitespace(CBString string) {
 
    return CBTrue;
}
