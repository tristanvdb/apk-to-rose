#!/bin/bash

malware=$1
directory=${malware%.*}

if [ ! -e $directory ] ; then $APK2JAVA_HOME/scripts/apk-to-java.sh $malware ; fi &> /dev/null

if [ ! -e $directory/jd.log ]
then
  echo "failed xml: $directory" >> test.log
elif [ `tail -n1 $directory/jd.log | grep "Failure" | wc -l` -eq 0 ]
then
  cd $directory

  echo "$directory"

  package=`cat apk/AndroidManifest.xml | grep "package=" | sed 's/.*package="//' | sed 's/">//' | sed 's/\./\//g'`

  lines=`cat apk/AndroidManifest.xml | grep -n "android\.intent\.category\.LAUNCHER" | awk 'BEGIN{FS=":"} { print $1}'`

  echo "  lines=$lines"

  for line in $lines
  do
#    echo "cat apk/AndroidManifest.xml | head -n$((line - 3)) | tail -n5"
#    cat apk/AndroidManifest.xml | head -n$((line - 3)) | tail -n5
#    echo "cat apk/AndroidManifest.xml | head -n$((line - 3)) | tail -n5 | grep \"<activity\" | grep \"android:name\""
#    cat apk/AndroidManifest.xml | head -n$((line - 3)) | tail -n5 | grep "<activity" | grep "android:name"
#    echo "cat apk/AndroidManifest.xml | head -n$((line - 3)) | tail -n5 | grep \"<activity\" | grep \"android:name\" | sed 's/.*android:name=\"\.//' | sed 's/\".*>//g'"
#    cat apk/AndroidManifest.xml | head -n$((line - 3)) | tail -n5 | grep "<activity" | grep "android:name" | sed 's/.*android:name=\"\.//' | sed 's/\".*>//g'
    entry_class=`cat apk/AndroidManifest.xml | head -n$((line - 3)) | tail -n5 | grep "<activity" | grep "android:name" | sed 's/.*android:name=\"\.//' | sed 's/\".*>//g' | sed 's/\./\//g'`
    if [ ! -z entry_class ]
    then
      entry_points="$package/$entry_class.java $entry_points"
    fi
  done

  echo "  entry_points=$entry_points"

  if [ ! -z entry_points ]
  then
    cd java

    echo "javac -classpath . -bootclasspath /media/ssd/projects/drafts/android-workspace/sdk/platforms/android-19/android.jar $entry_points" > ../javac.log
    javac -classpath . -bootclasspath /media/ssd/projects/drafts/android-workspace/sdk/platforms/android-19/android.jar $entry_points &>> ../javac.log
    if [ $? -eq 0 ]
    then
      echo "recompiled: $directory" >> ../../test.log
    else 
      echo "decompiled: $directory" >> ../../test.log
    fi
    cd ..
  else
    echo "no entry:   $directory" >> ../../test.log
  fi
  cd ..
else
  echo "failed jd:  $directory" >> test.log
fi

