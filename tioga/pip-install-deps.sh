source $INSTALL_DIR/bin/activate 
mpi4py_ver=3.1.5
python --version
pip install --upgrade pip
pip install cython psutil scikit-build 
pip install numpy scipy  matplotlib numba multiprocess "pybind11[global]" lxcat_data_parser

export HCC_AMDGPU_TARGET=$hip_arch
export CUPY_INSTALL_USE_HIP=1
pip install cupy --verbose --no-cache-dir --no-binary :all:

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
CC=$MPICC CXX=$MPICXX pip install . --config-settings=cmake.define.PARLA_ENABLE_HIP=ON 

cd $SCRIPT_DIR
