.PHONY: clean build

TARGET_GRADLE_VERSION=6.9
TARGET_GRADLE_WRAPPER_HERE_VERSION=0.7.2

all: clean build

clean:
	@rm -rfv build/

build: build/gradle-wrapper-here

build/gradle-wrapper-here:
	@./build.sh $(TARGET_GRADLE_VERSION) $(TARGET_GRADLE_WRAPPER_HERE_VERSION)
