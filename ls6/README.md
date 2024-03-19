# Building TPS dependencies on ls6

## Build dependencies

Install `python3.11`, build and install all c/c++ dependencies, build and install all pip dependencies.
The build directory where source code is downloaded and build is `WDIR=$ROOT_DIR/build`; the install directory is
`INSTALL_DIR=$ROOT_DIR/tps-env`, where `$ROOT_DIR` is the current directory where the script was launched.

Note: `python3.11` is installed in `$INSTALL_DIR/.python`

```
./script.sh # creates export_env, install c++ and pip dependencies
```

This script generates the file `$INSTALL_DIR/export_env` which defines some key enviromental variables to build `tps`.

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

Note make check gets stuck on the compute note (I guess because of calls to mpirun that should be replaced by ibrun).

To build all the stack, you can also use `./install-tps-bte.sh`
