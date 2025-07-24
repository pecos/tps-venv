#! /bin/bash

LOAD_MODULES_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

module purge
ml load TACC cmake ucc ucx xalt nvidia nvidia_math cuda openmpi/5.0.5

# export TACC_BOOST_DIR=/opt/apps/intel19/python3_9/boost/1.72
# export TACC_BOOST_LIB=/opt/apps/intel19/python3_9/boost/1.72/lib
# export TACC_BOOST_INC=/opt/apps/intel19/python3_9/boost/1.72/include
# export TACC_BOOST_BIN=/opt/apps/intel19/python3_9/boost/1.72/bin
# export BOOST_ROOT=/opt/apps/intel19/python3_9/boost/1.72
# export BOOST_ROOT=$TACC_BOOST_DIR

#Preset python path for the future
export PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/bin:/opt/apps/gcc14/cuda12/python3/3.11.8/bin:$PATH
export LD_LIBRARY_PATH=$LOAD_MODULES_SCRIPT_DIR/tps-env/.python/lib:/opt/apps/gcc14/cuda12/python3/3.11.8/lib:$LD_LIBRARY_PATH
python3 -V