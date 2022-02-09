#!/bin/bash

set -e

umask 022

CWD=`pwd`
export INSTALL_DIR=$CWD/install/jack1-android

export DEBARCH="arm64"
export LIBSUFFIX=""
export TARGET=aarch64-linux-gnu

rm -r $INSTALL_DIR/usr || true
mkdir -p $INSTALL_DIR
mkdir -p $INSTALL_DIR/usr/bin

cd $CWD/jack1
./autogen.sh

export CFLAGS="-fPIC -DUSE_SHMSEMAPHORE -DUSE_POSIX_SHM"
export LDFLAGS="-lrt"

./configure \
        --prefix=/usr \
        --libdir=/usr/lib/$TARGET \
        --enable-resize \
        --enable-timestamps \
        --enable-alsa \
        --enable-posix-shm \
        --enable-static=yes \
        --with-default-tmpdir=/run \
        --disable-iec61883 \
        --with-oldtrans \
        --disable-ensure-mlock

make clean
make -j 8
make install DESTDIR=$INSTALL_DIR

cd $CWD

dpkg-deb --build $INSTALL_DIR jack1-android_1.0-1_$DEBARCH.deb
