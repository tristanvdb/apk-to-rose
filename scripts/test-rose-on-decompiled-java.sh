#!/bin/bash

if [ -z $APK2ROSE_HOME ]
then
  echo "Needs to source apk-to-rose.rc"
  exit
fi

filename=$(basename $1)
filename=${filename%.*}

original=$(readlink -f $1)

rm -rf $filename
mkdir $filename

pushd $filename

echo
echo "***********************************"
echo "* Compiling $1 with javac *"
echo "***********************************"
echo
echo "javac -d `pwd` $original"
echo
echo "---------------"
echo

javac -d `pwd` $original &> javac.log

if [ $? -eq 0 ]
then
  echo
  echo "Success, see `pwd`/$1.class for results."
  echo
  echo "See `pwd`/javac.log for log."
  echo
else
  echo
  echo "Failure, invalid input file $original"
  echo
  echo "See `pwd`/javac.log for log."
  echo
  popd
  exit
fi

echo
echo "*************************************************************"
echo "* Compiling $1 with ROSE's identity translator *"
echo "*************************************************************"
echo
echo "$APK2ROSE_HOME/rose-install/bin/identityTranslator $original"
echo
echo "---------------"
echo

$APK2ROSE_HOME/rose-install/bin/identityTranslator $original &> rose.log

if [ $? -eq 0 ]
then
  echo
  echo "Success, see `pwd`/rose_output for results."
  echo
else
  echo
  echo "Failure of ROSE's identity translator on $original"
  echo
fi
echo "See `pwd`/rose.log for log."
echo

rm -rf javac-syntax-check-classes # created by ROSE when checking using javac to check the input file syntax

echo
echo "*******************************"
echo "* Decompiling $1.class *"
echo "*******************************"
echo
echo "java -jar $APK2JAVA_HOME/jd-cmd/jd-cli/target/jd-cli.jar $filename.class -od jd"
echo
echo "---------------"
echo

java -jar $APK2JAVA_HOME/jd-cmd/jd-cli/target/jd-cli.jar $filename.class -od jd &> jd.log

if [ $? -eq 0 ]
then
  echo
  echo "Success, see `pwd`/jd for results."
  echo
  echo "See `pwd`/jd.log for log."
  echo
else
  echo
  echo "Failure, cannot decompile $filename.class"
  echo
  echo "See `pwd`/jd.log for log."
  echo
  popd
  exit
fi

cd jd

echo
echo "*************************************************"
echo "* Compiling decompiled jd/$1 with javac *"
echo "*************************************************"
echo
echo "javac -d `pwd` $filename.java"
echo
echo "---------------"
echo

javac -d `pwd` $filename.java &> ../javac-jd.log

if [ $? -eq 0 ]
then
  echo
  echo "Success, see `pwd`/$1.class for results."
  echo
  echo "See `pwd`/../javac-jd.log for log."
  echo
else
  echo
  echo "Failure, invalid input file jd/$filename.java"
  echo
  echo "See `pwd`/../javac-jd.log for log."
  echo
  popd
  exit
fi

echo
echo "***************************************************************************"
echo "* Compiling decompiled jd/$1 with ROSE's identity translator *"
echo "***************************************************************************"
echo
echo "$APK2ROSE_HOME/rose-install/bin/identityTranslator $filename.java"
echo
echo "---------------"
echo


$APK2ROSE_HOME/rose-install/bin/identityTranslator $filename.java &> ../rose-jd.log

if [ $? -eq 0 ]
then
  echo
  echo "Success, see `pwd`/rose_output for results."
else
  echo
  echo "Failure of ROSE's identity translator on decompiled file jd/$1"
fi
echo
echo "See `pwd`/../rose-jd.log for log."
echo

popd

