#!/bin/bash

if [ -z $APK2ROSE_HOME ]
then
  echo "Needs to source apk-to-rose.rc"
  exit
fi

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]
then
  echo "Usage: $0 input.java rose-tool log-file"
  exit
fi

echo "---------------"
echo
echo "Compiling $1 with a ROSE tool: $3"
echo "  in `pwd`"
echo "  $APK2ROSE_HOME/rose-install/bin/$2 $1"
echo
echo "---------------"


$APK2ROSE_HOME/rose-install/bin/$2 $1.java &> $3

if [ $? -ne 0 ]
then
  echo "---------------"
  echo "Failure of ROSE's identity translator on decompiled file $1 in `pwd`"
  echo "  log: `pwd`/$3"
fi
echo "---------------"

rm -rf javac-syntax-check-classes

