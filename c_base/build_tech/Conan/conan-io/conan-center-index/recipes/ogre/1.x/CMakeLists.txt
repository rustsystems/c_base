cmake_minimum_required(VERSION 3.10.2)
project(cmake_wrapper)

include(conanbuildinfo.cmake)
conan_basic_setup(TARGETS)

add_subdirectory(source_subfolder)
