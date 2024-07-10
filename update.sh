#!/bin/sh
set -e

cd $LLVM_PROJECT_ROOT
git checkout main
git pull --ff-only
~/llvm-util/cmake.sh
