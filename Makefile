.PHONY: recast vanilla-rally

all: recast vanilla-rally

recast:
	./gradlew :recast:build

vanilla-rally:
	./gradlew :vanilla-rally:build

install-debug:
	./gradlew :vanilla-rally:installDebug
