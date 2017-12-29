.PHONY: clean build

TARGET_GRADLE_VERSION=4.4.1

all: clean build

clean:
	@rm -rfv build/

build: build/gradle-wrapper-here

build/gradle-wrapper-here:
	@./build.sh $(TARGET_GRADLE_VERSION)
