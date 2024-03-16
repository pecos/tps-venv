#!/bin/bash
INSTALL_DIR=$(pwd)
wget https://github.com/git-lfs/git-lfs/releases/download/v3.5.1/git-lfs-linux-amd64-v3.5.1.tar.gz && tar xvf git-lfs-linux-amd64-v3.5.1.tar.gz
cd git-lfs-3.5.1 &&  PREFIX=$INSTALL_DIR ./install.sh

cd $INSTALL_DIR
