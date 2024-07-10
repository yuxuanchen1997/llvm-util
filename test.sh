#!/bin/bash

~/llvm-util/ninja.sh && $LLVM_PROJECT_ROOT/build/bin/llvm-lit -v $@
