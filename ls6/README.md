# Building TPS dependencies on ls6

## Build dependencies

```
./script.sh # creates export_env, install c++ and pip dependencies
source ./install-git-lfs.sh
```

## Configure and build TPS

Make sure to set up the environment (this is also needed to run tps applications)

```
source load_modules.sh
source tps-venv/bin/activate
source export_env
```

Configure and build tps

```
cd tps
./bootstrap
mkdir build-gpu
cd build-gpu
../configure CUDA_ARCH=sm_75 --disable-valgrind --enable-gpu-cuda --enable-pybind11 --with-cuda=$CUDA_HOME
make -j 6
make -j 6 check TESTS="vpath.sh"
```

Note make check gets stuck on the compute note (I guess because of calls to mpirun that should be replaced by ibrun.
