cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(CppRobotics VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CPP_ROBOTICS_SRCS
	src/native_add.cpp
)

add_library(cpp_robotics_library SHARED
  ${CPP_ROBOTICS_SRCS}
  cpp_robotics.def
)

add_executable(cpp_robotics_test
  src/main.cpp
)

target_link_libraries(cpp_robotics_test
  cpp_robotics_library
)

set_target_properties(cpp_robotics_library PROPERTIES
    PUBLIC_HEADER native_add.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "cpp_robotics"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)
