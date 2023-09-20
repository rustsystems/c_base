
# clang -I/Users/brian/dev_space/Rust-Systems/c_base/src2/include -dynamic_lib -shared -o libcbase.dylib ./src/cbcore_memory.c ./src/cbstring.c


rm -rf ./build
mkdir build
cd build
cmake ../
make
sudo make install