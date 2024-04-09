# Building TPS dependencies on tioga 

## Build dependencies

Install `python3.12`, build and install all c/c++ dependencies, build and install all pip dependencies.
The build directory - where source code is downloaded and built - is `WDIR=$ROOT_DIR/build`; the install directory is
`INSTALL_DIR=$ROOT_DIR/tps-env`, where `$ROOT_DIR` is the current directory where the script was launched.

Note: `python3.12` is installed in `$INSTALL_DIR/.python`

```
./script.sh # creates export_env, install c++ and pip dependencies
./pip-install-deps.sh # install all python dependencies
```

This script generates the file `$INSTALL_DIR/export_env` which defines some key environment variables to build `tps`.

Note: 
- `git-lfs` is already present.
- Can not build `cupy`

## Configure and build TPS

Make sure to set up the environment (this is also needed to run tps applications)

```
source load_modules.sh
source tps-env/bin/activate
source tps-env/export_env
```

Configure and build tps

```
cd tps
./bootstrap
mkdir build-gpu
cd build-gpu
export MPI_DIR=/usr/tce/packages/cray-mpich-tce/cray-mpich-8.1.21-rocmcc-5.4.1-cce-15.0.0c
export RESOLVE_CRAY_LIB=/usr/tce/packages/cce-tce/cce-15.0.0c/cce/x86_64/lib/
export LD_LIBRARY_PATH=$RESOLVE_CRAY_LIB:$LD_LIBRARY_PATH
../configure --enable-gpu-hip HIP_ARCH=gfx90a --disable-valgrind --enable-pybind11 CPPFLAGS=-I$(python3 -c "import pybind11; print(pybind11.get_include())") 
make -j 6
make -j 6 check TESTS="vpath.sh"
```


To build all the stack, you can also use `./install-tps-bte.sh`

## Tests

Profile BTE on a single GPU

```
source startup-env.sh
flux submit -N 1 -t 1.5h --output=bte_run_single_gpu.log ./bte_run_single_gpu.sh 
```

Run TPS+BTE Strong Scaling
```
source startup-env.sh
./tps-bte-create-input.sh
for nn in 1 2 4 8 16; do flux submit -N $nn -n $(($nn*4)) -t 1h --output=tps-bte_${nn}.log ./tps-bte-scaling.sh $nn; done
```

Note: To run the strong scaling you'll need to explicitly patch TPS
```
diff --git a/src/equation_of_state.cpp b/src/equation_of_state.cpp
index 1e03825e..cc75b5c8 100644
--- a/src/equation_of_state.cpp
+++ b/src/equation_of_state.cpp
@@ -619,6 +619,7 @@ MFEM_HOST_DEVICE double PerfectMixture::computeBackgroundMassDensity(const doubl
 
   // assert(rhoB >= 0.0);
   if (rhoB < 0.) {
+    rhoB = 0.0;          
     // grvy_printf(GRVY_ERROR, "\nNegative background density -> %f\n", rhoB);
     printf("\nERROR: Negative background density -> %f\n", rhoB);
 #ifdef _GPU_
```

## TODO:
[ ] Build `metaphysicl` for full `masa` support
