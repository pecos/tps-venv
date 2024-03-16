# Building TPS dependencies on frontera

## Create a venv

To create a virtual enviroment do the following:
```
source load_modules.sh
mkdir tps-venv
cd tps-venv/
python3 -m venv --system-site-packages .
source bin/activate
```

## Install all dependencies

The following script should be used:
- `script.sh`: download, built, and locally install all c/c++ dependencies. It creates a file called `export_env` that defines useful enviromental variable.
- `install-git-lfs.sh`: [Optional] download and locally install `git lfs` (needed to check-out `tps`)
- `pip-install-deps.sh`: pip install all the needed libraries and builds `mpi4py` against our compiler. Note: I have installed `parla` dependencies but not `parla` itself 

Example
```
../script.sh #creates export_env
source ../install-git-lfs.sh
source ../pip-install-deps.sh
```

## Configure TPS

Make sure to set-up the enviroment
```
cd tps-venv/
source bin/activate
source ../load_modules.sh
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
