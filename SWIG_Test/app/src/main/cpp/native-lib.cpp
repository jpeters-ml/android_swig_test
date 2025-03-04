#include <string.h>
#include "native-lib.h"

#ifdef __cplusplus
extern "C" {
#endif

void process(foo *baz, const void *data, int32_t sz ) {
    memcpy((void *)baz, data, sz);
}

#ifdef __cplusplus
};
#endif