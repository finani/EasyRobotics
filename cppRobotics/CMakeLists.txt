cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(CppRobotics VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)

find_package(Eigen3 REQUIRED NO_MODULE)

set(CPP_ROBOTICS_SRCS
	src/cpp_add.cpp
)

set(CPP_ROBOTICS_EXTERNS
	extern/filter/FirstOrderFilter.cpp
)

add_library(cpp_robotics_library SHARED
  ${CPP_ROBOTICS_SRCS}
  ${CPP_ROBOTICS_EXTERNS}
)

add_executable(cpp_robotics
  src/main.cpp
)

target_link_libraries(cpp_robotics
  cpp_robotics_library
)

set_target_properties(cpp_robotics_library PROPERTIES
    PUBLIC_HEADER extern/CppRobotics.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "cpp_robotics"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)

add_subdirectory(test)
