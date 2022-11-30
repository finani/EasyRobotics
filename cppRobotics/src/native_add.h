#pragma once

  #include <stdint.h>

#ifdef _WIN32
  extern "C" {
#else
  extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif

  int32_t native_add(int32_t x, int32_t y);

#ifdef _WIN32
}
#endif
