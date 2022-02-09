#!/bin/bash

set -e

umask 022

CWD=`pwd`
export INSTALL_DIR=$CWD/install/android-shm

export DEBARCH="arm64"
export LIBSUFFIX=""
export TARGET=aarch64-linux-gnu

rm -r $INSTALL_DIR/usr || true
#rm -r $CWD/install/db || true
mkdir -p $INSTALL_DIR
mkdir -p $INSTALL_DIR/usr/bin

export DESTDIR=$INSTALL_DIR/

cd $CWD
make -C android-shm clean
make -C android-shm all
make -C android-shm install

dpkg-deb --build $INSTALL_DIR android-shm_0.9-1_$DEBARCH.deb
