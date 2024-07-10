#!/bin/bash

cd $LLVM_PROJECT_ROOT/build/
time ninja -j60 $@
