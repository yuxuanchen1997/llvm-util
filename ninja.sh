#!/bin/bash

cd ~/llvm-project/build/
time ninja -j60 $@
