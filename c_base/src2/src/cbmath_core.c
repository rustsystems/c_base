

#include "cbase.h"


CBInteger CBMathMax(CBInteger val1, CBInteger val2) {
    if (val1 > val2) {
        return val1;
    } else {
        return val2;
    }
}


CBInteger CBMathMin(CBInteger val1, CBInteger val2) {
    if (val1 < val2) {
        return val1;
    } else {
        return val2;
    }
}


