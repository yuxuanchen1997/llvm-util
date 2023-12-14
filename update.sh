#!/bin/sh
set -e

cd ~/llvm-project/
git checkout main
git pull --ff-only
~/llvm-util/cmake.sh
