#!/bin/bash -x
INSTALL_DIR=$(pwd)
WDIR=$INSTALL_DIR/build
make_cores=6
cuda_arch_number=75
code_branch=lowmach-bte-bindings

source bin/activate
source ../load_modules.sh
source export_env

TPS_DIR=$INSTALL_DIR/tps
git clone git@github.com:pecos/tps.git
cd $TPS_DIR && git checkout $code_branch

git clone git@github.com:ut-padas/boltzmann.git

git clone git@github.com:pecos/tps-inputs.git
cd tps-inputs && git checkout $code_branch

# cd $TPS_DIR
# ./bootstrap
# mkdir build-gpu
# cd build-gpu
# ../configure CUDA_ARCH=sm_75 --disable-valgrind --enable-gpu-cuda --enable-pybind11 --with-cuda=$CUDA_HOME CPPFLAGS=-I$(python3 -c "import pybind11; print(pybind11.get_include())")
# make -j 6
# make -j 6 check TESTS="vpath.sh"

cd $TPS_DIR
git branch 
./bootstrap
mkdir -p build-cpu-low-mach
cd build-cpu-low-mach
../configure CC=mpicc CXX=mpicxx --disable-valgrind --enable-pybind11 CPPFLAGS=-I$(python3 -c "import pybind11; print(pybind11.get_include())")

# mkdir build-gpu
# cd build-gpu
# ../configure CC=mpicc CXX=mpicxx CUDA_ARCH=$cuda_arch --disable-valgrind --enable-gpu-cuda --enable-pybind11 --with-cuda=$CUDA_HOME CPPFLAGS=-I$(python3 -c "import pybind11; print(pybind11.get_include())")
make -j $make_cores
make -j $make_cores  check TESTS="vpath.sh"
cd $INSTALL_DIR