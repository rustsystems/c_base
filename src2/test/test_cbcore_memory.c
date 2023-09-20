
#include <stdio.h>
#include "cbase.h"

int test_cbcore_memory_main(int argc, char* argv[]) {
    printf("starting test...\n");
    CBString str = Allocate("hello world");
    printf("%s\n", str);
    printf("done\n");
}