#! /bin/bash

module purge
module load cmake/3.24.2 cuda/11.4 gcc/9.4.0 impi/19.0.9

export TACC_BOOST_DIR=/opt/apps/intel19/python3_9/boost/1.72
export TACC_BOOST_LIB=/opt/apps/intel19/python3_9/boost/1.72/lib
export TACC_BOOST_INC=/opt/apps/intel19/python3_9/boost/1.72/include
export TACC_BOOST_BIN=/opt/apps/intel19/python3_9/boost/1.72/bin
export BOOST_ROOT=/opt/apps/intel19/python3_9/boost/1.72
