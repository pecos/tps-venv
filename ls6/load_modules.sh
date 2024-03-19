#! /bin/bash

LOAD_MODULES_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

module purge
module load cmake/3.24.2 cuda/11.4 gcc/9.4.0 impi/19.0.9

export TACC_BOOST_DIR=/opt/apps/intel19/python3_9/boost/1.72
export TACC_BOOST_LIB=/opt/apps/intel19/python3_9/boost/1.72/lib
export TACC_BOOST_INC=/opt/apps/intel19/python3_9/boost/1.72/include
export TACC_BOOST_BIN=/opt/apps/intel19/python3_9/boost/1.72/bin
export BOOST_ROOT=/opt/apps/intel19/python3_9/boost/1.72

#Preset python path for the future
export PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/bin:$PATH
export LD_LIBRARY_PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/lib:$LD_LIBRARY_PATH
