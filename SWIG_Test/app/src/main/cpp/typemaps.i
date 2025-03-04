/* Mapping for icom_nvm_status_tx_t structure */
%typemap(jtype) test "test"
%typemap(jstype) test "test"
%typemap(jni) test "jobject"
%typemap(in) test {
    jsclass cls = (*jenv)->FindClass(jenv, "test");
    jmethodID constructor = (*jenv)->GetMethodID(jenv, cls, "<init>", "(B)V");
    jfieldID foo_field = (*jenv)->GetFieldID(jenv, cls, "foo", "B");
    jobject obj = (*jenv)->NewObject(jenv, cls, constructor, $1.foo);
    $result = obj;
}
%typemap(out) test {
    jclass cls = (*jenv)->FindClass(jenv, "test");
    jfieldID foo_field = (*jenv)->GetFieldID(jenv, cls, "foo", "B");

    $result.foo = (*jenv)->GetByteField(jenv, $input, foo_field);
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