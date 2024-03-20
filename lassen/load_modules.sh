#! /bin/bash

LOAD_MODULES_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export COMPILER="gcc/9.3.1"
export CUDA_VER="11.2.0"
export CUDA_PATH="/usr/tce/packages/cuda/cuda-${CUDA_VER}"   

module --force purge
module load StdEnv
module swap base-gcc/8.3.1 ${COMPILER} 
module load cuda/${CUDA_VER} 
module list

#Preset python path for the future
export PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/bin:$PATH
export LD_LIBRARY_PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/lib:$LD_LIBRARY_PATH
