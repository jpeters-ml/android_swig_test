/* Mapping for foo structure */
%typemap(jtype) foo "foo"
%typemap(jstype) foo "foo"
%typemap(jni) foo "jobject"
%typemap(in) foo {
    jsclass cls = (*jenv)->FindClass(jenv, "foo");
    jmethodID constructor = (*jenv)->GetMethodID(jenv, cls, "<init>", "(B)V");
    jfieldID bar_field = (*jenv)->GetFieldID(jenv, cls, "bar", "B");
    jobject obj = (*jenv)->NewObject(jenv, cls, constructor, $1.bar);
    $result = obj;
}
%typemap(out) foo {
    jclass cls = (*jenv)->FindClass(jenv, "foo");
    jfieldID bar_field = (*jenv)->GetFieldID(jenv, cls, "bar", "B");

    $result.bar = (*jenv)->GetByteField(jenv, $input, bar_field);
}

// Mapping for uint8_t (scalar)
%typemap(jtype) uint8_t "byte"
%typemap(jstype) uint8_t "byte"
%typemap(jni) uint8_t "jbyte"
%typemap(javaout) uint8_t {
    return ($jnicall);
}
%typemap(in) uint8_t {
    $1 = (uint8_t)$input;
}
%typemap(out) uint8_t {
    $result = (jbyte)$1;
}

%typemap(jtype) (const void *, int32_t) "kotlin.ByteArray"
%typemap(jstype) (const void *, int32_t) "kotlin.ByteArray"
%typemap(jni) (const void *, int32_t) "jbyteArray"
%typemap(javaout) (const void *, int32_t) {
    return ($jnicall);
}
%typemap(in) (const void *data, int32_t size) {
    if ($input == null || $input.length != size) {
        throw new IllegalArgumentException("Expected a byte array of length " + size);
    }
    memcpy($1, $input, size);
}
%typemap(out) (const void *, int32_t) {
    jbyteArray result = (*jenv)->NewByteArray(jenv, size);
    if (result != NULL && $1 != NULL) {
        (*jenv)->SetByteArrayRegion(jenv, result, 0, size, (const jbyte *)$1);
    }
    $result = result;
}

// Mapping for int32_t
%typemap(jtype) int32_t "int"
%typemap(jstype) int32_t "int"
%typemap(jni) int32_t "jint"
%typemap(javaout) int32_t {
    return ($jnicall);
}
%typemap(in) int32_t {
    $1 = (int32_t)$input;
}
%typemap(out) int32_t {
    $result = (jint)$1;
}