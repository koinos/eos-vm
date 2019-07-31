#!/bin/bash
echo '$ gcc --version'
gcc --version
echo '$ scl enable devtoolset-8 bash'
scl enable devtoolset-8 bash
echo '$ gcc --version'
gcc --version
mkdir -p /root/tmp
cd /root/tmp
git clone --single-branch --branch release_80 https://git.llvm.org/git/llvm.git clang8
cd clang8
git checkout 18e41dc
cd tools
git clone --single-branch --branch release_80 https://git.llvm.org/git/lld.git
cd lld
git checkout d60a035
cd ../
git clone --single-branch --branch release_80 https://git.llvm.org/git/polly.git
cd polly
git checkout 1bc06e5
cd ../
git clone --single-branch --branch release_80 https://git.llvm.org/git/clang.git clang
cd clang
git checkout a03da8b
cd tools
mkdir extra
cd extra
git clone --single-branch --branch release_80 https://git.llvm.org/git/clang-tools-extra.git
cd clang-tools-extra
git checkout 6b34834
cd ..
cd ../../../../projects
git clone --single-branch --branch release_80 https://git.llvm.org/git/libcxx.git
cd libcxx
git checkout 1853712
cd ../
git clone --single-branch --branch release_80 https://git.llvm.org/git/libcxxabi.git
cd libcxxabi
git checkout d7338a4
cd ../
git clone --single-branch --branch release_80 https://git.llvm.org/git/libunwind.git
cd libunwind
git checkout 57f6739
cd ../
git clone --single-branch --branch release_80 https://git.llvm.org/git/compiler-rt.git
cd compiler-rt
git checkout 5bc7979
cd /root/tmp/clang8
mkdir build
cd build
cmake -G 'Unix Makefiles' -DCMAKE_INSTALL_PREFIX='/usr/local' -DLLVM_BUILD_EXTERNAL_COMPILER_RT=ON -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_ENABLE_LIBCXX=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_INCLUDE_DOCS=OFF -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_TARGETS_TO_BUILD=all -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
make install
cd /
rm -rf /root/tmp/clang8
rm /build-clang.sh