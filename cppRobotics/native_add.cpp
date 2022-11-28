#include <stdint.h>
#include "native_add.h"

int main()
{
    native_add(1, 2);
    return 0;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}
