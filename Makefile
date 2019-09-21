.PHONY: clean build

TARGET_GRADLE_VERSION=5.6.2

all: clean build

clean:
	@rm -rfv build/

build: build/gradle-wrapper-here

build/gradle-wrapper-here:
	@./build.sh $(TARGET_GRADLE_VERSION)
