.PHONY: depends recast vanilla-rally

all: depends recast vanilla-rally

depends:
	./build_zlib.sh
	./build_openal-soft.sh
	./build_freealut.sh

recast:
	./gradlew :recast:build

vanilla-rally:
	./gradlew :vanilla-rally:build

install-debug:
	./gradlew :vanilla-rally:installDebug
