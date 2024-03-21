SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=$(pwd)
INSTALL_DIR=$ROOT_DIR/tps-env
WDIR=$ROOT_DIR/build
make_cores=6

set -e

source $SCRIPT_DIR/load_modules.sh
source $INSTALL_DIR/bin/activate 
source $INSTALL_DIR/export_env

mpi4py_ver=3.1.5
python --version
pip install --upgrade pip
pip install cython==0.29.37 psutil scikit-build nvtx
pip install numpy scipy  matplotlib cupy-cuda11x numba multiprocess "pybind11[global]" lxcat_data_parser

python -c "import cupy"

MPICC=$(command -v mpicc)
MPICXX=$(command -v mpicxx)
cd $WDIR
wget https://github.com/mpi4py/mpi4py/releases/download/$mpi4py_ver/mpi4py-$mpi4py_ver.tar.gz \
&& tar -zxf mpi4py-$mpi4py_ver.tar.gz && cd mpi4py-$mpi4py_ver \
&& python setup.py build --mpicc=$MPICC && python setup.py install
cd $ROOT_DIR
python -c "import mpi4py"

cd $WDIR
git clone git@github.com:ut-parla/parla-experimental.git
cd parla-experimental
git submodule update --init --recursive
CC=$MPICC CXX=$MPICXX make all -j ${make_cores}
cd $ROOT_DIR
python -c "import parla"

#pip install --extra-index-url=https://pypi.nvidia.com cudf-cu11==24.2.* cuml-cu11==24.2.*
