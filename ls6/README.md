# Building TPS dependencies on ls6

Example

./script.sh #creates export_env
source ./install-git-lfs.sh
source ./pip-install-deps.sh

Configure and build TPS

Make sure to set up the environment (this is also needed to run tps applications)

cd tps-venv/
source bin/activate
source ../load_modules.sh
source export_env

Configure and build tps

cd tps
./bootstrap
mkdir build-gpu
cd build-gpu
../configure CUDA_ARCH=sm_75 --disable-valgrind --enable-gpu-cuda --enable-pybind11 --with-cuda=$CUDA_HOME
make -j 6
make -j 6 check TESTS="vpath.sh"

Note make check gets stuck on the compute note (I guess because of calls to mpirun that should be replaced by ibrun.
