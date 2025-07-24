#!/bin/bash -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

if [ ! -d recastnavigation ]; then
    git clone https://github.com/recastnavigation/recastnavigation
fi

if [[ ! -v NPROC ]]; then NPROC=$(nproc); fi

for ANDROID_ABI in armeabi-v7a arm64-v8a x86 x86_64; do
    mkdir -p recastnavigation/build-$ANDROID_ABI
    pushd recastnavigation/build-$ANDROID_ABI
    cmake .. \
        -G Ninja \
        -DRECASTNAVIGATION_DEMO=OFF \
        -DRECASTNAVIGATION_TESTS=OFF \
        -DRECASTNAVIGATION_EXAMPLES=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        -DANDROID_STL=c++_shared \
        -DANDROID_ABI=$ANDROID_ABI \
        -DCMAKE_TOOLCHAIN_FILE="${NDK_ROOT}/build/cmake/android.toolchain.cmake"
    cmake --build . -j $NPROC
    popd
done
