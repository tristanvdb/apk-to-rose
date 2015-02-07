#!/bin/bash

if [ -z $APK2ROSE_HOME ]
then
  echo "Needs to source apk-to-rose.rc"
  exit
fi

if [ -z $1 ] || [ -z $2 ]
then
  echo "Usage: $0 input.java log-file"
  exit
fi

echo "---------------"
echo
echo "Compiling decompiled $1 with javac"
echo "  in `pwd`"
echo "  javac -d `pwd` $1"
echo
echo "---------------"

javac -d `pwd` $1 &> $2

if [ $? -ne 0 ]
then
  echo "---------------"
  echo "Failure, invalid input file $1 in `pwd`"
  echo "  log: `pwd`/$2"
fi
echo "---------------"

