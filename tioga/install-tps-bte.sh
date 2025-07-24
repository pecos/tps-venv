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
#export MPI_DIR=/usr/tce/packages/cray-mpich-tce/cray-mpich-8.1.21-rocmcc-5.4.1-cce-15.0.0c
#export RESOLVE_CRAY_LIB=/usr/tce/packages/cce-tce/cce-15.0.0c/cce/x86_64/lib/
#export LD_LIBRARY_PATH=$RESOLVE_CRAY_LIB:$LD_LIBRARY_PATH
../configure --enable-gpu-hip HIP_ARCH=$hip_arch --disable-valgrind --enable-pybind11 CPPFLAGS=-I$(python3 -c "import pybind11; print(pybind11.get_include())") 
make -j $make_cores
make -j $make_cores  check TESTS="vpath.sh"
