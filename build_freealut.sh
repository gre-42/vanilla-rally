#!/bin/bash -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

if [ ! -d freealut ]; then
    git clone https://github.com/vancegroup/freealut.git
fi

if [[ ! -v NPROC ]]; then NPROC=$(nproc); fi

for ANDROID_ABI in armeabi-v7a arm64-v8a x86 x86_64; do
    mkdir -p freealut/build-$ANDROID_ABI
    pushd freealut/build-$ANDROID_ABI
    cmake .. \
        -G Ninja \
        -DBUILD_SHARED_LIBS=off \
        -DBUILD_EXAMPLES=off \
        -DBUILD_TESTS=off \
        -DANDROID_STL=c++_shared \
        -DANDROID_ABI=$ANDROID_ABI \
        -DCMAKE_TOOLCHAIN_FILE="${NDK_ROOT}/build/cmake/android.toolchain.cmake" \
        -DOPENAL_LIBRARY=../../openal-soft/build-$ANDROID_ABI/libopenal.a \
        -DOPENAL_INCLUDE_DIR=../../openal-soft/include
    cmake --build . -j $NPROC
    popd
done
