.PHONY: clean build

TARGET_GRADLE_VERSION=7.4.2
TARGET_GRADLE_WRAPPER_HERE_VERSION=0.8.0

all: clean build

clean:
	@rm -rfv build/

build: build/gradle-wrapper-here

build/gradle-wrapper-here:
	@./build.sh $(TARGET_GRADLE_VERSION) $(TARGET_GRADLE_WRAPPER_HERE_VERSION)
