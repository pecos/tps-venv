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

export ROCM_HOME=/usr/tce/packages/rocmcc-tce/rocmcc-5.4.1-cce-15.0.0c

#Preset python path for the future
export PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/bin:$PATH
export LD_LIBRARY_PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/lib:$LD_LIBRARY_PATH
