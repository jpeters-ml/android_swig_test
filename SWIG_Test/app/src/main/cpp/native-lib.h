
#ifndef __native_lib_h__
#define __native_lib_h__

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _foo {
    uint8_t bar;
} foo;

void process(foo *baz, const void *data, int32_t sz ) ;

#ifdef __cplusplus
}
#endif

#endif