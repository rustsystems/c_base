cmake_minimum_required(VERSION 3.7)

project(cbase
        VERSION 0.0.1
        DESCRIPTION "A C-Base Library, capturing basic C-Constructs, Functions, Algorithms etc"
        HOMEPAGE_URL https://github.com/rustsystems/c_base
        LANGUAGES C)
# set_property(SOURCE CBase PROPERTY C_STANDARD C23)

# set(CMAKE_INCLUDE_CURRENT_DIR ON)
# set(CMAKE_CXX_CREATE_STATIC_LIBRARY OFF)
# file( GLOB LIB_SOURCES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/src/" *.c )
# # file( GLOB APP_SOURCES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/src" *.c )
# file( GLOB LIB_INCLUDES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/include/" *.h )

# # add_library(CBase SHARED)
# add_library(CBase STATIC
#         "src/cbcore_memory.c"
#         "src/cbstring.c")
# target_compile_definitions(CBase PUBLIC CBase)

# set_target_properties(CBase PROPERTIES LINKER_LANGUAGE CXX)
# set_target_properties(CBase PROPERTIES OUTPUT_NAME cbase SUFFIX .dylib)

# set_target_properties(CBase PROPERTIES LINKER_FLAGS -Wl,-dynamic_linker,/usr/lib/dyld.so
# )

# target_include_directories(CBase PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")
# target_sources(CBase PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src")

# try_compile()
# install(TARGETS ${installable_libs} DESTINATION lib)
# # install include headers
# install(FILES cbase.h DESTINATION include)


#Generate the static library from the library sources
add_library(cbase STATIC 
    src/cbcore_memory.c 
    src/cbmath_core.c 
    src/cbstring.c
)

target_include_directories(cbase
    PUBLIC 
        ${PROJECT_SOURCE_DIR}/include
)
# Add an executable with the above sources
add_executable(cbase_test 
    test/test_cbase.c
    test/test_cbcore_memory.c
    test/test_cbdata.c
    test/test_cbmath_core.c
    test/test_cbstring.c
)

# link the new hello_library target with the hello_binary target
target_link_libraries( cbase_test
    PRIVATE 
        cbase
)


# Binaries
# install (TARGETS cmake_examples_inst_bin
#     DESTINATION bin)

# Library
# Note: may not work on windows
install (TARGETS cbase
    LIBRARY DESTINATION lib)

# Header files
install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/ 
    DESTINATION include/cbase)
