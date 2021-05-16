#!/usr/bin/env bash

# Copyright 2014-2021 Ray Holder
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"
__BUILD_DIR__="${__DIR__}/build"

GRADLE_VERSION="${1}"
GRADLE_WRAPPER_HERE_VERSION="${2}"
WRAPPER_TAR="gradle-wrapper-${GRADLE_VERSION}.tar.gz"
FINAL_BINARY="gradle-wrapper-here"

function check_environment () {
    programs=(curl tar unzip cat)
    for program in "${programs[@]}"; do
        check_program_exists "$program"
    done
}

function check_program_exists () {
    if [ ! -x "$(which ${1})" ]; then
        echo "Environment Error: ${1} not found on the path or not executable"
        exit 1
    fi
}

function prepare_build () {
    echo "Preparing build in ${__BUILD_DIR__}..."
    mkdir -p ${__BUILD_DIR__}
    cd ${__BUILD_DIR__}
}

function prepare_gradle () {
    # grab a full binary Gradle install
    echo "Fetching Gradle ${GRADLE_VERSION}..."
    curl -O -L https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
    unzip gradle-${GRADLE_VERSION}-bin.zip
}

function prepare_wrapper () {
    echo "Generating wrapper in ${__BUILD_DIR__}..."
    gradle-${GRADLE_VERSION}/bin/gradle wrapper

    echo "Collecting wrapper in ${WRAPPER_TAR}..."
    tar zcf ${WRAPPER_TAR} --numeric-owner gradle/ gradlew gradlew.bat
}

function prepare_binary () {
    echo "Assembling binary..."
    sed "s/__VERSION__/${GRADLE_WRAPPER_HERE_VERSION}/g; s/__GRADLE_VERSION__/${GRADLE_VERSION}/g" ../gradle-wrapper-here.sh.template > gradle-wrapper-here.sh
    cat gradle-wrapper-here.sh ${WRAPPER_TAR} > ${FINAL_BINARY}
    chmod +x ${FINAL_BINARY}
    echo "Successfully generated: ${__BUILD_DIR__}/${FINAL_BINARY}"
}

function prepare_checksum() {
    echo "Checking for binary..."
    file ${FINAL_BINARY}

    echo "Generating SHA256 checksum..."
    sha256sum ${FINAL_BINARY} | tee sha256sums

    echo "Verifying SHA256 checksum..."
    sha256sum -c sha256sums
}

check_environment
prepare_build
prepare_gradle
prepare_wrapper
prepare_binary
prepare_checksum
