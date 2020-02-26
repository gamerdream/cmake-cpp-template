#!/bin/sh

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # ...
  echo -- Linux detected.
  CMAKE_GENERATOR="Unix Makefiles"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OSX
  echo -- MAC detected.
  CMAKE_GENERATOR="Xcode"
elif [[ "$OSTYPE" == "cygwin" ]]; then
  # POSIX compatibility layer and Linux environment emulation for Windows
  echo -- CygWin not supported.
  exit 1
elif [[ "$OSTYPE" == "msys" ]]; then
  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
  echo -- MinGW not supported.
  exit 1
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  # ...
  echo -- FreeBSD not supported.
  exit 1
else
  # Unknown.
  echo -- Platform not supported.
  exit 1
fi

pushd . > /dev/null
SCRIPT_PATH="${BASH_SOURCE[0]}"
if ([ -h "${SCRIPT_PATH}" ]); then
  while([ -h "${SCRIPT_PATH}" ]); do cd `dirname "$SCRIPT_PATH"`; 
  SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`; done
fi
cd `dirname ${SCRIPT_PATH}` > /dev/null
SCRIPT_PATH=`pwd`;
SOURCE_PATH=$SCRIPT_PATH/../
TARGET_PATH=$SCRIPT_PATH/../targets
mkdir -p $TARGET_PATH
pushd $TARGET_PATH > /dev/null
cmake -G "$CMAKE_GENERATOR" $TARGET_PATH.. 2>&1
popd $TARGET_PATH > /dev/null
popd > /dev/null
