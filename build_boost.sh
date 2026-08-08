#!/bin/bash -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

if [ ! -d Boost-for-Android ]; then
    git clone https://github.com/moritz-wundke/Boost-for-Android.git
fi

if [[ ! -v NPROC ]]; then NPROC=$(nproc); fi

pushd Boost-for-Android
./build-android.sh $NDK_ROOT --with-libraries=regex,url --arch=armeabi-v7a,arm64-v8a,x86,x86_64
