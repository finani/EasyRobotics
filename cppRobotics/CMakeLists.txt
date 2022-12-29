cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(CppRobotics VERSION 1.0.0 LANGUAGES CXX)

# set(CMAKE_CXX_STANDARD 14)
# set(CMAKE_CXX_FLAG -Werror -Wall -Wextra)
add_compile_options(-std=c++14 -Wall -Wextra)
if(NOT ANDROID)
  add_compile_options(-Werror)
endif()

# if(ANDROID) # Android
#   message("Android")
#   set(SYSTEM_NUMBER 0)
# elseif(IOS) # iOS
#   message("iOS")
#   set(SYSTEM_NUMBER 1)
# elseif(APPLE) # macOS, iOS, tvOS or watchOS
#   message("macOS, tvOS or watchOS")
#   set(SYSTEM_NUMBER 2)
# elseif(WIN32) # Windows
#   message("Windows including Win64")
#   set(SYSTEM_NUMBER 3)
# # elseif(${LINUX}) # cmake > 3.25
# elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux") # Linux
#   message("Linux")
#   set(SYSTEM_NUMBER 4)
# endif()

set(CPP_ROBOTICS_SRCS
  ${CMAKE_SOURCE_DIR}/src/cpp_add.cpp
)

set(CPP_ROBOTICS_EXTERNS
  ${CMAKE_SOURCE_DIR}/extern/filter/HighPassFilter.cpp
  ${CMAKE_SOURCE_DIR}/extern/filter/LowPassFilter.cpp

  ${CMAKE_SOURCE_DIR}/extern/guidance/PureProportionalNavigation.cpp
)

add_library(cpp_robotics_library SHARED
  ${CPP_ROBOTICS_SRCS}
  ${CPP_ROBOTICS_EXTERNS}
)

add_executable(cpp_robotics
  ${CMAKE_SOURCE_DIR}/src/main.cpp
)

target_link_libraries(cpp_robotics
  cpp_robotics_library
)

set_target_properties(cpp_robotics_library PROPERTIES
    # PUBLIC_HEADER extern/CppRobotics.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "cpp_robotics"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)

if(GTEST)
  add_subdirectory(test)
endif()
