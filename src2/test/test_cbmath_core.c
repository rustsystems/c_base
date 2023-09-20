

#include <assert.h>
#include <stdio.h>

#include "cbase.h"


CBBool test_cbmath_max_lmax() {
    CBInteger lmax = 100;
    CBInteger rmin = 1;
    CBInteger left_result = CBMathMax(lmax, rmin);
    assert(left_result == 100);

    return 1;
}


CBBool test_cbmath_max_rmax() {
    CBInteger lmin = 1;
    CBInteger rmax = 100;    
    CBInteger right_result = CBMathMax(lmin, rmax);
    assert(right_result == 100);

    return 1;
}


int test_cbmath_core_main(int argc, char argv[]) {
    printf("test_cbmath_max \n");
    int res1 = test_cbmath_max_lmax();
    int res2 = test_cbmath_max_rmax();


    
}