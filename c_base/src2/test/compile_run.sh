
export CBASE_LIB=/Users/brian/dev_space/Rust-Systems/c_base/src2/libcbase.dylib
export CBASE_INCLUDE=/Users/brian/dev_space/Rust-Systems/c_base/src2/include
clang -llibcbase -I$CBASE_INCLUDE test_cbcore_memory.c