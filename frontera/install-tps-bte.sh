#!/bin/bash -x
INSTALL_DIR=$(pwd)
WDIR=$INSTALL_DIR/build
make_cores=6
cuda_arch_number=75

source bin/activate
source ../load_modules.sh
source export_env

TPS_DIR=$INSTALL_DIR/tps
git clone git@github.com:pecos/tps.git
cd $TPS_DIR && git checkout boltzmann-integration

git clone git@github.com:ut-padas/boltzmann.git

git clone git@github.com:pecos/tps-inputs.git
cd tps-inputs && git checkout boltzmann-integration

cd $TPS_DIR
./bootstrap
mkdir build-gpu
cd build-gpu
../configure CUDA_ARCH=sm_75 --disable-valgrind --enable-gpu-cuda --enable-pybind11 --with-cuda=$CUDA_HOME CPPFLAGS=-I$(python3 -c "import pybind11; print(pybind11.get_include())")
make -j 6
make -j 6 check TESTS="vpath.sh"
