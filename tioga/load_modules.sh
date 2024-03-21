#! /bin/bash

LOAD_MODULES_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export ROCM_VER="5.4.1"
export CCE_VER="15.0.0c"
export MPICH_VER="8.1.28"

module --force purge
module load StdEnv
module load rocmcc-tce/${ROCM_VER}-cce-${CCE_VER}
module load cray-mpich-tce/${MPICH_VER}
module list

#Export ROCM_HOME (using some dark magic)
#$(grep COMPILER_DIR $(command -v hipcc)) && export ROCM_HOME=$COMPILER_DIR && unset COMPILER_DIR

export ROCM_HOME=/opt/rocm-${ROCM_VER}

# Note: module rocmcc-tce will not add shared libraries to ld_library_path

#Preset python path for the future
export PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/bin:$PATH
export LD_LIBRARY_PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/lib:$LD_LIBRARY_PATH

