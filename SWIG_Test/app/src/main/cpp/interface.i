%module swigtest_native_swig

%{
#include "native-lib.h"
%}

%include "./typemaps.i"

%include "native-lib.h"