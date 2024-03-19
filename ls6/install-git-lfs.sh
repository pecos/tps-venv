#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
INSTALL_DIR=$SCRIPT_DIR/tps-env
WDIR=$SCRIPT_DIR/build

cd $WDIR
wget https://github.com/git-lfs/git-lfs/releases/download/v3.5.1/git-lfs-linux-amd64-v3.5.1.tar.gz && tar xvf git-lfs-linux-amd64-v3.5.1.tar.gz
cd git-lfs-3.5.1 &&  PREFIX=$INSTALL_DIR ./install.sh

cd $SCRIPT_DIR
