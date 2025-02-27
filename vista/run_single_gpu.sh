#!/bin/bash -x

WDIR=$(pwd)
source load_modules.sh
source tps-env/bin/activate
python3 --version

TPS_DIR=$WDIR/tps
cd $TPS_DIR/boltzmann/BESolver/python/
pwd

mkdir -p batched_bte
fout="batched_bte/test_ts_0"
solver="transient"
atol=1e-8
rtol=1e-8
freq=13.56e6
npts=128
dt=1e-2
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq $freq -dt $dt -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 2 -out_fname $fout -verbose 1 -max_iter 1000 -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=256
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq $freq -dt $dt -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 2 -out_fname $fout -verbose 1 -max_iter 1000 -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=512
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq $freq -dt $dt -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 2 -out_fname $fout -verbose 1 -max_iter 1000 -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=1024
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq $freq -dt $dt -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 2 -out_fname $fout -verbose 1 -max_iter 1000 -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=2048
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq $freq -dt $dt -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 2 -out_fname $fout -verbose 1 -max_iter 1000 -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=4096
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq $freq -dt $dt -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 2 -out_fname $fout -verbose 1 -max_iter 1000 -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01


fout="batched_bte/test_ss_0"
solver="steady-state"
npts=128
atol=1e-8
rtol=1e-8
max_iter=50
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq 0.0 -dt 1e-3 -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 3 -out_fname $fout -verbose 1 -max_iter $max_iter -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=256
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq 0.0 -dt 1e-3 -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 3 -out_fname $fout -verbose 1 -max_iter $max_iter -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=512
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq 0.0 -dt 1e-3 -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 3 -out_fname $fout -verbose 1 -max_iter $max_iter -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=1024
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq 0.0 -dt 1e-3 -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 3 -out_fname $fout -verbose 1 -max_iter $max_iter -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=2048
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq 0.0 -dt 1e-3 -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 3 -out_fname $fout -verbose 1 -max_iter $max_iter -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01

npts=4096
echo "npts = " $npts
python3 bte_0d3v_batched_driver.py -threads 16 -solver_type $solver -l_max 1 -sp_order 3 -spline_qpts 5 -Efreq 0.0 -dt 1e-3 -plot_data 1 -Nr 127 --ee_collisions 1 -use_gpu 1 -cycles 3 -out_fname $fout -verbose 1 -max_iter $max_iter -atol $atol -rtol $rtol -c lxcat_data/eAr_crs.6sp_Tg_0.5eV -ev_max 17.425 -n_pts $npts -Te 8.54666667E-01




