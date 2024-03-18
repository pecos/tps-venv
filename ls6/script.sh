#!/bin/bash -x
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
INSTALL_DIR=$(pwd)/tps-env
WDIR=$INSTALL_DIR/build
make_cores=6
cuda_arch_number=75

set -e

source $SCRIPT_DIR/load_modules.sh
module list

mkdir $WDIR
mkdir $INSTALL_DIR


source build_python.sh
python -m venv tps-env .

# MASA LOCAL INSTALL
cd $WDIR
export MASA_DIR=$INSTALL_DIR
git clone https://github.com/dreamer2368/MASA.git masa
cd masa && git checkout 887d5e26e3865bd6415503d62f9a557bbd3da4dc
./boostrap && ./configure --prefix=$MASA_DIR && make -j ${make_cores} && make install
cd $WDIR

export grvy_ver="0.37.0"
export GRVY_DIR=$INSTALL_DIR
wget https://github.com/hpcsi/grvy/releases/download/$grvy_ver/grvy-$grvy_ver.tar.gz
tar xfz grvy-$grvy_ver.tar.gz
cd grvy-$grvy_ver
./configure CXXFLAGS="-std=c++11" --prefix=$GRVY_DIR  --enable-boost-headers-only && make -j ${make_cores} && make install
rm -rf $GRVY_DIR/lib/*.la $GRVY_DIR/lib/*.a
cd $WDIR

gslib_ver="1.0.7"
export GSLIB_DIR=$INSTALL_DIR
wget https://github.com/Nek5000/gslib/archive/refs/tags/v$gslib_ver.tar.gz
tar xvf v$gslib_ver.tar.gz
cd gslib-$gslib_ver \
    && make -j ${make_cores} CC=mpicc CFLAGS="-O3 -fPIC" DESTDIR=$GSLIB_DIR
cd $WDIR

export HYPRE_DIR=$INSTALL_DIR
export HYPRE_INC=$HYPRE_DIR/include
export HYPRE_LIB=$HYPRE_DIR/lib
wget  https://github.com/hypre-space/hypre/archive/refs/tags/v2.26.0.tar.gz \
    && tar -zxvf v2.26.0.tar.gz \
    && cd hypre-2.26.0/src/ \
    && ./configure --enable-shared --disable-fortran --prefix=$HYPRE_DIR \
    && make -j ${make_cores} \
    && make check \
    && make install
cd $WDIR

export METIS_DIR=$INSTALL_DIR
wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz
tar -xvf metis-5.1.0.tar.gz
cd metis-5.1.0 && \
    make config prefix=$METIS_DIR shared=1 && \
    make -j ${make_cores} && make install
cd $WDIR

export HDF5_DIR=$INSTALL_DIR
wget https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_12_2/source/hdf5-1.12.2.tar.gz
tar -xvf hdf5-1.12.2.tar.gz
cd hdf5-1.12.2 && \
CC=mpicc ./configure --enable-parallel --prefix=$INSTALL_DIR && \
make -j ${make_cores} && make install
cd $WDIR


mfem_ver="4.5.2"
mfem_prefix=$INSTALL_DIR
wget https://github.com/mfem/mfem/archive/refs/tags/v$mfem_ver.tar.gz && tar xvf v$mfem_ver.tar.gz

cd mfem-$mfem_ver \
    && unset MFEM_DIR \
    && make pcuda CUDA_ARCH=sm_${cuda_arch_number} PREFIX=$mfem_prefix \
       MFEM_DEBUG=NO STATIC=NO SHARED=YES \
       HYPRE_OPT="-I$HYPRE_INC" HYPRE_LIB="-L$HYPRE_LIB -lHYPRE" \
       MFEM_USE_METIS_5=YES METIS_OPT="-I$METIS_DIR/include" METIS_LIB="-L$METIS_DIR/lib -lmetis" \
       MFEM_USE_GSLIB=YES GSLIB_OPT="-I$GSLIB_DIR/include" GSLIB_LIB="-L$GSLIB_DIR/lib -lgs" -j ${make_cores}\
       && cd examples && make -j ${make_cores} && cd .. && make install
cd $WDIR

export MFEM_DIR=$mfem_prefix

cd $INSTALL_DIR
echo export MASA_DIR=$MASA_DIR > export_env
echo export GRVY_DIR=$GRVY_DIR >> export_env
echo export GSLIB_DIR=$GSLIB_DIR >> export_env
echo export HYPRE_DIR=$HYPRE_DIR >> export_env
echo export METIS_DIR=$METIS_DIR >> export_env
echo export MFEM_DIR=$MFEM_DIR >> export_env
echo export CUDA_HOME=$TACC_CUDA_DIR >> export_env
echo export EXTRA_LD_LIBRARY_PATH=$INSTALL_DIR/lib >> export_env
