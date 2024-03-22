#!/bin/bash -x
WDIR=$(pwd)
TPS_DIR=$WDIR/tps
TPS_INPUTS_DIR=$WDIR/tps/tps-inputs/axisymmetric/argon/lowP/six-species-maxwell-rates
cd $TPS_INPUTS_DIR

echo $(pwd)
ls

python3 gen_par.py --par_fname=plasma.6sp.tps2boltzmann.x4.ini --ngpus_per_node=4 --solver_type="steady-state" --out_fname="ss" --lxcat=$WDIR/tps/boltzmann/BESolver/python/lxcat_data/eAr_crs.6sp_Tg_0.5eV -sub_clusters 1024 512 256 128 64 -node_count 1 2 4 8 16

#python3 gen_par.py --ngpus_per_node=4 --solver_type="transient" --out_fname="ts" --lxcat=$WDIR/tps/boltzmann/BESolver/python/lxcat_data/eAr_crs.6sp_Tg_0.5eV -sub_clusters 1024 512 256 128 64 -node_count 1 2 4 8 16

cd $WDIR

cat >run.sbatch<<EOF
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Frontera CLX nodes
#
#   *** MPI Job in Normal Queue ***
# 
# Last revised: 20 May 2019
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch clx.mpi.slurm" on a Frontera login node.
#
#   -- Use ibrun to launch MPI codes on TACC systems.
#      Do NOT use mpirun or mpiexec.
#
#   -- Max recommended MPI ranks per CLX node: 56
#      (start small, increase gradually).
#
#   -- If you're running out of memory, try running
#      fewer tasks per node to give each task more memory.
#
#----------------------------------------------------

#SBATCH -J tps-bte         # Job name
#SBATCH -o .tps-bte-.o%j   # Name of stdout output file
#SBATCH -e .tps-bte-.e%j   # Name of stderr error file
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
##SBATCH --mail-user=username@tacc.utexas.edu

# Any other commands must follow all #SBATCH directives...
source load_modules.sh
source tps-env/bin/activate
source tps-env/export_env

module list
pwd
date

WDIR=\$(pwd)
TPS_DIR=\$WDIR/tps-venv/tps

cd \$TPS_DIR
mkdir -p build-gpu && cd build-gpu
make all -j16
cd ../ && cp src/*.py build-gpu/src/.

cd \$WDIR
PAR_FILE_HOME=\$TPS_DIR/tps-inputs/axisymmetric/argon/lowP/six-species-maxwell-rates
cd \$PAR_FILE_HOME
git checkout restart_output-plasma.sol.h5
git checkout ../six-species-maxwell-rates-x4/restart_output-plasma-x4.sol.h5
git checkout ../six-species-maxwell-rates-x16/restart_output-plasma-x16.sol.h5

python3 --version
export PARLA_NUM_THREADS=8  

ibrun ./../../../../../build-gpu/src/tps-bte_0d3v.py -run plasma.6sp.tps2boltzmann.x4.$1.ini
cd \$WDIR
EOF
# chmod +x run.sbatch