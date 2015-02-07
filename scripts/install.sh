#!/bin/bash

if [ -z $APK2JAVA_HOME ]
then
  echo "APK2JAVA_HOME is undefined."
  if [ ! -e apk-to-java ]
  then
    echo "Get local copy of APK2JAVA..."
    git clone git@github.com:tristanvdb/apk-to-java.git
    cd apk-to-java
    ./scripts/install.sh
    cd ..
  fi
  export APK2JAVA_HOME=`pwd`/apk-to-java
fi

> apk-to-rose.rc
echo "export APK2ROSE_HOME=`pwd`" >> apk-to-rose.rc
echo >> apk-to-rose.rc
echo "[ -z \$APK2JAVA_HOME ] && source $APK2JAVA_HOME/apk-to-java.rc" >> apk-to-rose.rc
echo >> apk-to-rose.rc
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

mkdir -p rose-build
mkdir -p rose-install

cd rose-build

if [ ! -e Makefile ]
then
  $APK2ROSE_HOME/rose/configure --with-boost=$1 --prefix=$APK2ROSE_HOME/rose-install
fi

make install-core -j8

cd ..

