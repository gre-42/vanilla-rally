#!/bin/bash -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

if [ ! -d openal-soft ]; then
    git clone https://github.com/kcat/openal-soft.git
fi

for ANDROID_ABI in armeabi-v7a arm64-v8a x86 x86_64; do
    mkdir -p openal-soft/build-$ANDROID_ABI
    pushd openal-soft/build-$ANDROID_ABI
    cmake .. \
        -G Ninja \
        -DLIBTYPE=STATIC \
        -DANDROID_STL=c++_shared \
        -DANDROID_ABI=$ANDROID_ABI \
        -DCMAKE_TOOLCHAIN_FILE="${NDK_ROOT}/build/cmake/android.toolchain.cmake"
    cmake --build . -j $(nproc)
    popd
done
