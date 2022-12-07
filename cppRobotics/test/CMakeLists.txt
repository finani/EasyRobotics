file(GLOB_RECURSE TEST_SOURCES
  LIST_DIRECTORIES false
    *.cpp
)

add_executable(cpp_robotics_test
  ${TEST_SOURCES}
)

add_test(NAME cpp_robotics_test
  COMMAND
    cpp_robotics_test
)

target_link_libraries(cpp_robotics_test
  PUBLIC
    cpp_robotics_library
    gtest
    pthread
)
