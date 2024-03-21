#!/bin/bash -x
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=$(pwd)
INSTALL_DIR=$ROOT_DIR/tps-env
WDIR=$ROOT_DIR/build
make_cores=6
hip_arch=gfx90a

set -e

source $SCRIPT_DIR/load_modules.sh
source $INSTALL_DIR/bin/activate 
source $INSTALL_DIR/export_env

mpi4py_ver=3.1.5
python --version
pip install --upgrade pip
pip install cython==0.29.37 psutil scikit-build 
pip install numpy scipy  matplotlib numba multiprocess "pybind11[global]" lxcat_data_parser

MPICC=$(command -v mpicc)
MPICXX=$(command -v mpicxx)

cd $WDIR
wget https://github.com/mpi4py/mpi4py/releases/download/$mpi4py_ver/mpi4py-$mpi4py_ver.tar.gz \
rm -rf mpi4py-$mpi4py_ver && tar -zxf mpi4py-$mpi4py_ver.tar.gz && cd mpi4py-$mpi4py_ver \
&& python setup.py build --mpicc=$MPICC && python setup.py install
cd $ROOT_DIR
python -c "import mpi4py"

cd $WDIR
rm -rf parla-experimental
git clone git@github.com:ut-parla/parla-experimental.git
cd parla-experimental
git submodule update --init --recursive
CC=$MPICC CXX=$MPICXX pip install . --config-settings=cmake.define.PARLA_ENABLE_HIP=ON 
cd $ROOT_DIR
python -c "import parla"

export HCC_AMDGPU_TARGET=$hip_arch
export CUPY_INSTALL_USE_HIP=1
export LD_LIBRARY_PATH_SWAP=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$ROCM_HOME/lib:$LD_LIBRARY_PATH
echo $ROCM_HOME
pip install cupy
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH_SWAP
python -c "import cupy"

cd $SCRIPT_DIR
