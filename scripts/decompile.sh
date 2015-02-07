#!/bin/bash

if [ -z $APK2ROSE_HOME ]
then
  echo "Needs to source apk-to-rose.rc"
  exit
fi

if [ -z $1 ] || [ -z $2 ]
then
  echo "Usage: $0 input.class log-file"
  exit
fi

echo "---------------"
echo
echo "Decompiling $1.java"
echo "  in `pwd`"
echo "  java -jar $APK2JAVA_HOME/jd-cmd/jd-cli/target/jd-cli.jar $1 -od jd"
echo
echo "---------------"

java -jar $APK2JAVA_HOME/jd-cmd/jd-cli/target/jd-cli.jar $1 -od jd &> $2

if [ $? -ne 0 ]
then
  echo "---------------"
  echo "Failure, cannot decompile $1 in `pwd`"
  echo "  log: `pwd`/$2"
fi
echo "---------------"

