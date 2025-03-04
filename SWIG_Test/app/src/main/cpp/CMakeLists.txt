# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html.
# For more examples on how to use CMake, see https://github.com/android/ndk-samples.

# Sets the minimum CMake version required for this project.
cmake_minimum_required(VERSION 3.22.1)

# Declares the project name. The project name can be accessed via ${ PROJECT_NAME},
# Since this is the top level CMakeLists.txt, the project name is also accessible
# with ${CMAKE_PROJECT_NAME} (both CMake variables are in-sync within the top level
# build script scope).
project("swigtest")

set(CMAKE_C_STANDARD 99)

find_package(SWIG REQUIRED) # Locate SWIG installation
include(UseSWIG) # Add SWIG to CMake

set(SWIG_INTERFACE interface.i) # Path to SWIG interface file
set(CMAKE_SWIG_FLAGS -package com.micro_leads.swigtest.test) # Custom package name parameter

set_property(SOURCE interface.i PROPERTY SWIG_MODULE_NAME swigtest_native_swig) # Set module name

include_directories(${JAVA_INCLUDE_PATH})
include_directories(
        .
)

file(REMOVE_RECURSE ${CMAKE_SOURCE_DIR}/.swig)

# Add native source files
set(SOURCES
        native-lib.h
        native-lib.cpp
)

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.
#
# In this top level CMakeLists.txt, ${CMAKE_PROJECT_NAME} is used to define
# the target library name; in the sub-module's CMakeLists.txt, ${PROJECT_NAME}
# is preferred for the same purpose.
#
# In order to load a library into your app from Java/Kotlin, you must call
# System.loadLibrary() and pass the name of the library defined here;
# for GameActivity/NativeActivity derived applications, the same library name must be
# used in the AndroidManifest.xml file.
add_library(${CMAKE_PROJECT_NAME} SHARED
        # List C/C++ source files with relative paths to this CMakeLists.txt.
        ${SOURCES}
)

# Add SWIG library
swig_add_library(
        "${CMAKE_PROJECT_NAME}_native_swig" # name
        LANGUAGE java # language
        SOURCES ${SWIG_INTERFACE} # interface file
        OUTFILE_DIR ${CMAKE_SOURCE_DIR}/.swig # output wrapper file path
        OUTPUT_DIR ${CMAKE_SOURCE_DIR}/../java/com/micro_leads/swigtest/test # output Java files path
)

set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES LINKER_LANGUAGE CXX)

# Link swig lib with native lib
target_link_libraries("${CMAKE_PROJECT_NAME}_native_swig" ${JNI_LIBRARIES} ${CMAKE_PROJECT_NAME})

# Specifies libraries CMake should link to your target library. You
# can link libraries from various origins, such as libraries defined in this
# build script, prebuilt third-party libraries, or Android system libraries.
target_link_libraries(${CMAKE_PROJECT_NAME}
        # List libraries link to the target library
        android
        log
        ${JNI_LIBRARIES}
)