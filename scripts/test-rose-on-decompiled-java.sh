#!/bin/bash

if [ -z $APK2ROSE_HOME ]
then
  echo "Needs to source apk-to-rose.rc"
  exit
fi

if [ -z $1 ] || [ -z $2 ]
then
  echo "Usage: $0 input-no-extension rose-tool"
  exit
fi

filename=$(basename $1)
filename=${filename%.*}

original=$(readlink -f $1)

rm -rf $filename-$2
mkdir $filename-$2

pushd $filename-$2

$APK2ROSE_HOME/scripts/compile-javac.sh $original javac.log

$APK2ROSE_HOME/scripts/compile-rose.sh $original $2 rose.log

$APK2ROSE_HOME/scripts/decompile.sh $filename.class jd.log

cd jd

$APK2ROSE_HOME/scripts/compile-javac.sh $filename.java ../jd-javac.log

$APK2ROSE_HOME/scripts/compile-rose.sh $filename.java $2 ../jd-rose.log

popd

