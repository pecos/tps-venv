#!/bin/bash -x

# Submit as
# for nn in 1 2 4 8 16; do flux submit -N $nn -n $(($nn*4))-t 1h --output=tps-bte_ss_${nn}.log ./tps-bte-scaling.sh $nn; done 
WDIR=$(pwd)
TPS_DIR=$WDIR/tps
TPS_INPUTS_DIR=$WDIR/tps/tps-inputs/axisymmetric/argon/lowP/six-species-maxwell-rates
cd $TPS_INPUTS_DIR

NNODES=$1

cd $WDIR

source load_modules.sh
source tps-env/bin/activate
source tps-env/export_env

module list
pwd
date

TPS_DIR=$WDIR/tps

PAR_FILE_HOME=$TPS_DIR/tps-inputs/axisymmetric/argon/lowP/six-species-maxwell-rates
cd $PAR_FILE_HOME
[[  $FLUX_TASK_RANK -eq 0 ]] && echo $FLUX_TASK_RANK 
[[ $FLUX_TASK_RANK -eq 0 ]] && git checkout restart_output-plasma.sol.h5

python3 --version
export PARLA_NUM_THREADS=8  

$TPS_DIR/build-gpu/src/tps-bte_0d3v.py -run plasma.6sp.tps2boltzmann_ss_${NNODES}.ini 
cd $WDIR
