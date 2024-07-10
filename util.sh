#!/bin/sh
set -e

CWD=$(pwd)
while [[ $CWD != "/" && $(basename $CWD) != "llvm-project" ]]; do
  CWD=$(dirname $CWD)
done

if [[ $(basename $CWD) == "llvm-project" ]]; then
  echo "Found LLVM Root: $CWD"
  export LLVM_PROJECT_ROOT=$CWD
else
  echo "Did not find llvm-project root!"
  exit 1
fi

~/llvm-util/$1.sh ${@:2}
