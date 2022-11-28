cmake_minimum_required(VERSION 3.7 FATAL_ERROR)

project(native_add_library VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(native_add_library SHARED
  native_add.cpp
  native_add.def
)

add_executable(native_add_test
  native_add.cpp
)

set_target_properties(native_add_library PROPERTIES
    PUBLIC_HEADER native_add.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "native_add"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)
