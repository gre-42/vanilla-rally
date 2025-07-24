.PHONY: depends recast vanilla-rally

all: depends vanilla-rally

depends:
	./build_zlib.sh
	./build_openal-soft.sh
	./build_freealut.sh
	./build_recastnavigation.sh

vanilla-rally:
	# ./gradlew :vanilla-rally:build
	./gradlew :vanilla-rally:bundleRallyRelease

install-debug:
	./gradlew :vanilla-rally:installDebug
