.PHONY: recast osm-rally

all: recast osm-rally

recast:
	./gradlew :recast:build

osm-rally:
	./gradlew :osm-rally:build

install-debug:
	./gradlew :osm-rally:installDebug
