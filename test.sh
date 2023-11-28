#!/bin/bash

~/llvm-util/ninja.sh && ~/llvm-project/build/bin/llvm-lit -v $@
