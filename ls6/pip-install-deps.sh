source $INSTALL_DIR/bin/activate

mpi4py_ver=3.1.5
python --version
pip install --upgrade pip
pip install cython psutil scikit-build nvtx
pip install numpy scipy  matplotlib cupy-cuda12x numba multiprocess "pybind11[global]" lxcat_data_parser

MPICC=$(command -v mpicc)
MPICXX=$(command -v mpicxx)
cd $WDIR
wget https://github.com/mpi4py/mpi4py/releases/download/$mpi4py_ver/mpi4py-$mpi4py_ver.tar.gz \
&& tar -zxf mpi4py-$mpi4py_ver.tar.gz && cd mpi4py-$mpi4py_ver \
&& python setup.py build --mpicc=$MPICC && python setup.py install

cd $WDIR
git clone git@github.com:ut-parla/parla-experimental.git
cd parla-experimental
git submodule update --init --recursive
CC=$MPICC CXX=$MPICXX make all -j ${make_cores}

cd $SCRIPT_DIR
#pip install --extra-index-url=https://pypi.nvidia.com cudf-cu11==24.2.* cuml-cu11==24.2.*
