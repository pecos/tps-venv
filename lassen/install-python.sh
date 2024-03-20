# Requires ROOT_DIR INSTALL_DIR and WDIR to be set

export PYINSTALL_DIR=$INSTALL_DIR/.python

cd $WDIR
wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz
tar zxvf openssl-1.1.1l.tar.gz
cd openssl-1.1.1l
./config --prefix=$PYINSTALL_DIR --openssldir=$PYINSTALL_DIR zlib shared  
make -j $make_cores \
  && make install
cd $ROOT_DIR

export PATH=$PYINSTALL_DIR/bin:$PATH
export LD_LIBRARY_PATH=$PYINSTALL_DIR/lib:$PYINSTALL_DIR/lib64:$LD_LIBRARY_PATH

cd $WDIR
wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz
tar xzf Python-3.12.2.tgz
cd Python-3.12.2

./configure --prefix=$PYINSTALL_DIR --with-openssl=$PYINSTALL_DIR --enable-optimizations --with-lto --with-computed-gotos --with-system-ffi --enable-shared
make -j $make_cores
make altinstall
cd $ROOT_DIR


python3.12 -m ssl
python3.12 -m pip install --upgrade pip setuptools wheel

ln -s $PYINSTALL_DIR/bin/python3.12          $PYINSTALL_DIR/bin/python3
ln -s $PYINSTALL_DIR/bin/python3.12          $PYINSTALL_DIR/bin/python
ln -s $PYINSTALL_DIR/bin/pip3.12             $PYINSTALL_DIR/bin/pip3
ln -s $PYINSTALL_DIR/bin/pip3.12             $PYINSTALL_DIR/bin/pip
ln -s $PYINSTALL_DIR/bin/pydoc3.12           $PYINSTALL_DIR/bin/pydoc
ln -s $PYINSTALL_DIR/bin/idle3.12            $PYINSTALL_DIR/bin/idle
ln -s $PYINSTALL_DIR/bin/python3.12-config   $PYINSTALL_DIR/bin/python-config

python3 -V
