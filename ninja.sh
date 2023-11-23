#!/bin/bash

cd ~/llvm-project/build/
ninja -j60 $@
