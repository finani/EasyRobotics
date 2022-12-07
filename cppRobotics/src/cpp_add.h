#include <stdint.h>

#if defined(__cplusplus)
#ifdef _WIN32
extern "C" {
#else
extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif
#endif

int32_t cpp_add(int32_t x, int32_t y);

#if defined(__cplusplus)
#ifdef _WIN32
} // extern "C"
#endif
#endif
