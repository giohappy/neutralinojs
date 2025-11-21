#!/usr/bin/env bash
set -e

# CONFIG = Debug o Release (default Debug)
CONFIG="$1"
if [ -z "$CONFIG" ]; then
    CONFIG="Debug"
fi

BUILD_DIR="build_linux"

#rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake -DCMAKE_BUILD_TYPE="$CONFIG" ..
make -j"$(nproc)"
