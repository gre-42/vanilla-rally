.PHONY: depends recast vanilla-rally distclean

all: depends vanilla-rally

depends:
	./build_boost.sh
	# ./build_freealut.sh
	./build_openal-soft.sh
	./build_recastnavigation.sh
	./build_zlib.sh

vanilla-rally:
	# ./gradlew :vanilla-rally:build
	./gradlew :vanilla-rally:bundleRallyRelease

install-debug:
	# $ adb devices
	# $ ANDROID_SERIAL=12345ABCDE
	ANDROID_SERIAL=$(DEVICE) ./gradlew :vanilla-rally:installExtendedDebug -PtargetAbi=$(ABI)

distclean:
	rm -rf Boost-for-Android
	rm -rf freealut
	rm -rf openal-soft
	rm -rf recastnavigation
	rm -rf zlib
