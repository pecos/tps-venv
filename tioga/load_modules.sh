#! /bin/bash

LOAD_MODULES_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export ROCM_VER="6.4.0"
export MPICH_VER="8.1.32"

module --force purge
module load StdEnv
module load rocmcc/${ROCM_VER}-magic
module load cray-mpich/${MPICH_VER}
module list

#Export ROCM_HOME (using some dark magic)
#$(grep COMPILER_DIR $(command -v hipcc)) && export ROCM_HOME=$COMPILER_DIR && unset COMPILER_DIR

export ROCM_HOME=/opt/rocm-${ROCM_VER}

# Note: module rocmcc-tce will not add shared libraries to ld_library_path
#export RESOLVE_CRAY_LIB=/usr/tce/packages/cce-tce/cce-15.0.0c/cce/x86_64/lib/

#export LD_LIBRARY_PATH=$RESOLVE_CRAY_LIB:$LD_LIBRARY_PATH

#Preset python path for the future
export PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/bin:$PATH
export LD_LIBRARY_PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/lib:$LD_LIBRARY_PATH

