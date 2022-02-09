#!/bin/bash

set -e

umask 022

. cross.cfg

CWD=`pwd`
export INSTALL_DIR=$CWD/install/opensles-alsa

export DEBARCH="arm64"

rm -r $INSTALL_DIR/usr || true
rm -r $INSTALL_DIR/etc || true
mkdir -p $INSTALL_DIR

cd $CWD
make -C opensles-alsa clean
make -C opensles-alsa
make -C opensles-alsa install DESTDIR=$INSTALL_DIR/

cd $CWD

dpkg-deb --build $INSTALL_DIR opensles-alsa_1-android7_$DEBARCH.deb
