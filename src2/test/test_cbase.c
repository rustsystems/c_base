
#include <stdio.h>


int test_cbcore_memory_main(int argc, char* argv[]);
int test_cbmath_core_main(int argc, char* argv[]);
int test_cbstring_main(int argc, char* argv[]);

int main(int argc, char* argv[]) {
    printf("test_cbcore_memory_main\n");
    int cbcore_main = test_cbcore_memory_main(argc, argv);
    printf("\t ...done.\n");
    
    printf("test_cbmath_core_main\n");
    int cbmath_core_main = test_cbmath_core_main(argc, argv);
    printf("\t ...done.\n");
    
    printf("test_cbstring_main\n");
    int cbstring_main = test_cbstring_main(argc, argv);
    printf("\t ...done.\n");
}