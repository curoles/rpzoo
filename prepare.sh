#!/usr/bin/env bash

bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3); on_yellow=$(tput setab 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
cyan=$(tput setaf 6)
gray=$(tput setaf 7)
normal=$(tput sgr0)

THIS_DIR="$(realpath $(dirname "${BASH_SOURCE[0]}"))"

TOOLS_DIR="$(realpath $THIS_DIR/../tools)"

mkdir -p $TOOLS_DIR

echo "${bold}${green}Check CMake installation${normal}"
if [ ! -f "$TOOLS_DIR/cmake/bin/cmake" ]; then
  pushd $TOOLS_DIR
  mkdir -p ./cmake
  wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.22.5/cmake-3.22.5-linux-x86_64.sh
  sh cmake-linux.sh -- --skip-license --prefix=$TOOLS_DIR/cmake
  rm cmake-linux.sh
  popd
fi

export PATH=$TOOLS_DIR/cmake/bin:$PATH
cmake --version

echo "${bold}${green}Check Go installation${normal}"
if [ ! -f "$TOOLS_DIR/go/bin/go" ]; then
  pushd $TOOLS_DIR
  wget -q -O go.tar.gz https://go.dev/dl/go1.18.4.linux-amd64.tar.gz
  rm -rf ./go
  tar -C $TOOLS_DIR -xzf go.tar.gz
  rm go.tar.gz
  $TOOLS_DIR/go/bin/go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
  $TOOLS_DIR/go/bin/go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
  popd
fi

export PATH=$TOOLS_DIR/go/bin:$PATH
export PATH=$(go env GOPATH)/bin:$PATH

echo "${bold}${green}Check Python grpcio installation${normal}"
FOUND_PY_GRPCIO=`pip3 list | grep grpcio`
if [ "$FOUND_PY_GRPCIO" == "" ]; then
  python3 -m pip install grpcio
fi

echo "${bold}${green}Check Python grpcio-tools installation${normal}"
FOUND_PY_GRPCIO_TOOLS=`pip3 list | grep grpcio-tools`
if [ "$FOUND_PY_GRPCIO_TOOLS" == "" ]; then
  python3 -m pip install grpcio-tools
fi

echo "${bold}${green}Check Erlang/OTP installation${normal}"
if [ ! -f "$TOOLS_DIR/erlang/bin/erl" ]; then
  pushd $TOOLS_DIR
  wget -q -O otp_src.tar.gz https://github.com/erlang/otp/releases/download/OTP-25.0.3/otp_src_25.0.3.tar.gz
  rm -rf ./otp_src_25.0.3
  tar -C $TOOLS_DIR -zxf otp_src.tar.gz
  cd otp_src_25.0.3
  export ERL_TOP=`pwd`
  ./configure --prefix=$TOOLS_DIR/erlang
  make
  make install
  cd ..
  rm otp_src.tar.gz
  rm -rf ./otp_src_25.0.3
  popd
fi

export PATH=$TOOLS_DIR/erlang/bin:$PATH
erl -version

echo "${bold}${green}Check Elixir installation${normal}"
if [ ! -f "$TOOLS_DIR/elixir/bin/elixir" ]; then
  pushd $TOOLS_DIR
  wget -q -O elixir.zip https://github.com/elixir-lang/elixir/releases/download/v1.13.4/Precompiled.zip
  unzip elixir.zip -d elixir
  rm elixir.zip
  popd
fi

export PATH=$TOOLS_DIR/elixir/bin:$PATH
elixir --version

echo "${bold}${cyan}Env variable PATH is:${normal}"
echo $PATH
