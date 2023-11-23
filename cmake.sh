#!/bin/sh

cd ~/llvm-project/
rm -rf build
mkdir build
cd build

cmake \
	-G Ninja \
	-DCMAKE_CXX_COMPILER=clang++ \
	-DCMAKE_C_COMPILER=clang \
	-DCMAKE_ASM_COMPILER=clang \
	-DCMAKE_ASM_COMPILER_ID=Clang \
	-DLLVM_TARGETS_TO_BUILD="X86" \
	-DLLVM_USE_LINKER=lld \
	-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt;lld" \
	-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
	-DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-redhat-linux-gnu \
	-DLLVM_ENABLE_DUMP=ON \
	-DLLVM_ENABLE_ASSERTIONS=OFF \
	-DCMAKE_BUILD_TYPE=Debug \
	-DCMAKE_C_FLAGS="-fno-omit-frame-pointer -mno-omit-leaf-frame-pointer" \
	-DCMAKE_CXX_FLAGS="-fno-omit-frame-pointer -mno-omit-leaf-frame-pointer" \
	-DLLVM_APPEND_VC_REV=OFF \
	../llvm

~/llvm-util/ninja.sh $@
