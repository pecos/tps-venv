#!/bin/bash -x

# Perform a strong scaling test of TPS+BTE
# Please use tps-bte-create-input.sh to generate the input files
# Submit as
# for nn in 1 2 4 8 16; do flux submit -N $nn -n $(($nn*4)) -t 1h --output=tps-bte_${nn}.log ./tps-bte-scaling.sh $nn; done 
WDIR=$(pwd)
TPS_DIR=$WDIR/tps
TPS_INPUTS_DIR=$WDIR/tps/tps-inputs/axisymmetric/argon/lowP/six-species-maxwell-rates
cd $TPS_INPUTS_DIR

NNODES=$1

cd $WDIR

source load_modules.sh
source tps-env/bin/activate
source tps-env/export_env
export PARLA_NUM_THREADS=8  

[[  $FLUX_TASK_RANK -eq 0 ]] && echo "Check enviroment on Rank $FLUX_TASK_RANK"
[[  $FLUX_TASK_RANK -eq 0 ]] && module list
[[  $FLUX_TASK_RANK -eq 0 ]] && pwd
[[  $FLUX_TASK_RANK -eq 0 ]] && date
[[  $FLUX_TASK_RANK -eq 0 ]] && python3 --version

PAR_FILE_HOME=$TPS_DIR/tps-inputs/axisymmetric/argon/lowP/six-species-maxwell-rates
cd $PAR_FILE_HOME
[[ $FLUX_TASK_RANK -eq 0 ]] && git checkout restart_output-plasma.sol.h5
[[ $FLUX_TASK_RANK -eq 0 ]] && git checkout ../six-species-maxwell-rates-x4/restart_output-plasma-x4.sol.h5
[[ $FLUX_TASK_RANK -eq 0 ]] && git checkout ../six-species-maxwell-rates-x16/restart_output-plasma-x16.sol.h5
[[ $FLUX_TASK_RANK -eq 0 ]] && ln -sf ../six-species-maxwell-rates-x4/restart_output-plasma-x4.sol.h5 . 
[[ $FLUX_TASK_RANK -eq 0 ]] && ln -sf ../six-species-maxwell-rates-x16/restart_output-plasma-x16.sol.h5 . 

# To run the steady state
$TPS_DIR/build-gpu/src/tps-bte_0d3v.py -run plasma.6sp.tps2boltzmann.x16.ss.$1.ini 

# To run the transient
[[ $FLUX_TASK_RANK -eq 0 ]] && git checkout restart_output-plasma.sol.h5
[[ $FLUX_TASK_RANK -eq 0 ]] && git checkout ../six-species-maxwell-rates-x4/restart_output-plasma-x4.sol.h5
[[ $FLUX_TASK_RANK -eq 0 ]] && git checkout ../six-species-maxwell-rates-x16/restart_output-plasma-x16.sol.h5
$TPS_DIR/build-gpu/src/tps-bte_0d3v.py -run plasma.6sp.tps2boltzmann.x16.ts.$1.ini 

cd $WDIR
