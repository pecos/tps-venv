# Building TPS dependencies on ls6

## Build dependencies

Install `python3.12`, build and install all c/c++ dependencies, and build and install all pip dependencies.

Directories:
- `ROOT_DIR`: The directory the script was launched from.
- `WDIR=$ROOT_DIR/build`: The directory where source code is downloaded, untarred, and built
- `INSTALL_DIR=$ROOT_DIR/tps-env`: The directory where libraries, executables, and includes are installed. This is also where the python virtual environment is located

Note: `python3.12` is installed in `$INSTALL_DIR/.python`

To build all dependencies 
```
./script.sh # creates export_env, install c/c++  dependencies
./pip-install-deps.sh # install pip dependencies
```

The script `script.sh` generates the file `$INSTALL_DIR/export_env` which defines some key environment variables to build `tps`.

### Issues:
- I can not build `cudf` and `cuml`.
- Because of Giles's GPU course, this was executed only on a single GPU

## Configure and build TPS

Make sure to set up the environment (this is also needed to run tps applications)

```
source startup-env.sh
```

Configure and build tps

```
cd tps
./bootstrap
mkdir build-gpu
cd build-gpu
../configure CUDA_ARCH=sm_80 --disable-valgrind --enable-gpu-cuda --enable-pybind11 --with-cuda=$CUDA_HOME CPPFLAGS=-I$(python3 -c "import pybind11; print(pybind11.get_include())")
make -j 6
make -j 6 check TESTS="vpath.sh"
```

Note make check gets stuck on the compute note (I guess because of calls to mpirun that should be replaced by ibrun).

To build all the stack, you can also use `./install-tps-bte.sh`
