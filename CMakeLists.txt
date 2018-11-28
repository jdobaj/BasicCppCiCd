cmake_minimum_required (VERSION 3.3)

# TODO installation https://github.com/pablospe/cmake-example-library

project (BasicCppCiCd)

set_property (GLOBAL PROPERTY USE_FOLDERS ON)

set (CMAKE_CXX_STANDARD 14)
set (CMAKE_CXX_STANDARD_REQUIRED ON)

set (THREADS_PREFER_PTHREAD_FLAG ON)
find_package (Threads REQUIRED)

add_subdirectory (third-party EXCLUDE_FROM_ALL)
add_subdirectory (lib)
add_subdirectory (app)

enable_testing ()