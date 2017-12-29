#!/usr/bin/env bash

# Copyright 2014-2017 Ray Holder
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

set -o nounset
set -o pipefail
set -o errexit

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

VERSION=0.5.0
GRADLE_VERSION=4.4.1

function usage () {
        cat << EOF
Usage: gradle-wrapper-here [directory]

  Use gradle-wrapper-here to drop a Gradle wrapper into the given directory.

Examples:

  gradle-wrapper-here ./
  gradle-wrapper-here potato-project
  gradle-wrapper-here fruit/banana-stand

You can find the latest version and file bugs at https://github.com/rholder/gradle-wrapper-here.

Gradle version: ${GRADLE_VERSION}
gradle-wrapper-here: ${VERSION}
EOF
}

function check_environment () {
    programs=(tar awk pwd)
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

function extract_gradle_wrapper () {
    echo "Extracting Gradle wrapper to $(pwd)"
    ARCHIVE=$(awk '/^__ARCHIVE_BEGIN__/ {print NR + 1; exit 0; }' ${__FILE__})
    tail -n+${ARCHIVE} ${__FILE__} | tar zxv
}

TARGET_DIR=${1:-}
if [ -n "${TARGET_DIR}" ]; then
    cd "${TARGET_DIR}"
    extract_gradle_wrapper
else
    usage
    exit 1
fi

exit 0

__ARCHIVE_BEGIN__
