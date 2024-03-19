#!/bin/bash -x
ROOT_DIR=$(pwd)
make_cores=6

source load_modules.sh
source tps-env/bin/activate
source tps-env/export_env

TPS_DIR=$ROOT_DIR/tps
git clone git@github.com:pecos/tps.git
cd $TPS_DIR && git checkout boltzmann-integration

git clone git@github.com:ut-padas/boltzmann.git

git clone git@github.com:pecos/tps-inputs.git
cd tps-inputs && git checkout boltzmann-integration

cd $TPS_DIR
./bootstrap
mkdir build-gpu
cd build-gpu
../configure CUDA_ARCH=$cuda_arch --disable-valgrind --enable-gpu-cuda --enable-pybind11 --with-cuda=$CUDA_HOME CPPFLAGS=-I$(python3 -c "import pybind11; print(pybind11.get_include())")
make -j $make_cores
make -j $make_cores  check TESTS="vpath.sh"
