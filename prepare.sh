#!/usr/bin/env bash

THIS_DIR="$(realpath $(dirname "${BASH_SOURCE[0]}"))"

TOOLS_DIR="$(realpath $THIS_DIR/../tools)"

mkdir -p $TOOLS_DIR

if [ ! -f "$TOOLS_DIR/cmake/bin/cmake" ]; then
  pushd $TOOLS_DIR
  mkdir -p ./cmake
  wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.22.5/cmake-3.22.5-linux-x86_64.sh
  sh cmake-linux.sh -- --skip-license --prefix=$TOOLS_DIR/cmake
  rm cmake-linux.sh
  popd
fi

FOUND_PY_GRPCIO=`pip3 list | grep grpcio`
if [ "$FOUND_PY_GRPCIO" == "" ]; then
  python3 -m pip install grpcio
fi

FOUND_PY_GRPCIO_TOOLS=`pip3 list | grep grpcio-tools`
if [ "$FOUND_PY_GRPCIO_TOOLS" == "" ]; then
  python3 -m pip install grpcio-tools
fi

export PATH=$TOOLS_DIR/cmake/bin:$PATH

cmake --version