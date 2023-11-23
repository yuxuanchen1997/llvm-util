#!/bin/bash

cd ~/llvm-project/
git diff -U0 --no-color HEAD^ | python3 clang/tools/clang-format/clang-format-diff.py -i -p1
