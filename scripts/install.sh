#!/bin/bash

> apk-to-rose.rc
echo "export APK_TO_ROSE_DIR=`pwd`" >> apk-to-rose.rc
>> apk-to-rose.rc
source apk-to-rose.rc

if [ ! -e rose ]
then
  git clone git@github.com:rose-compiler/edg4x-rose.git rose
fi

if [ ! -e rose/configure ]
then
  cd rose
  ./build
  cd ..
fi

rm -rf rose-build rose-install

mkdir rose-build
mkdir rose-install

cd rose-build

$APK_TO_ROSE_DIR/rose/configure --with-boost=$1 --prefix=$APK_TO_ROSE_DIR/rose-install

make install-core -j8

cd ..

