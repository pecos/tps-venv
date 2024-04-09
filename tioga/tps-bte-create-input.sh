#!/bin/bash -x

# Run this script (from login node) to generate the *.ini files for tps-bte-scaling.sh

WDIR=$(pwd)
TPS_DIR=$WDIR/tps
TPS_INPUTS_DIR=$WDIR/tps/tps-inputs/axisymmetric/argon/lowP/six-species-maxwell-rates

source startup-env.sh

cd $TPS_INPUTS_DIR

echo $(pwd)
ls

python3 gen_par.py --par_fname=plasma.6sp.tps2boltzmann.x16.ini --ngpus_per_node=1 --solver_type="steady-state" --out_fname="ss" --lxcat=$WDIR/tps/boltzmann/BESolver/python/lxcat_data/eAr_crs.6sp_Tg_0.5eV -sub_clusters 1024 512 256 128 64 -node_count 1 2 4 8 16
python3 gen_par.py --par_fname=plasma.6sp.tps2boltzmann.x16.ini --ngpus_per_node=1 --solver_type="transient" --out_fname="ts" --lxcat=$WDIR/tps/boltzmann/BESolver/python/lxcat_data/eAr_crs.6sp_Tg_0.5eV -sub_clusters 1024 512 256 128 64   -node_count 1 2 4 8 16

cd $WDIR

