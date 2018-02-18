#!/bin/bash
kernel_dir=$PWD
export CONFIG_FILE="z2_plus_defconfig"
export ARCH=arm64
export SUBARCH=arm64
export LOCALVERSION="-R2_0.02"
export KBUILD_BUILD_USER="ST12"
export KBUILD_BUILD_HOST="BLR"
export COMPILER_NAME="DTC-7.0"
export CLANG_TRIPLE="aarch64-linux-gnu-"
export CROSS_COMPILE="${HOME}/build/z2/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-"
export CLANG_TCHAIN="${HOME}/build/z2/dtc-7.0-tmp/out/7.0/bin/clang"
export LD_LIBRARY_PATH="${TOOL_CHAIN_PATH}/../lib"
export objdir="${kernel_dir}/out"
export builddir="${kernel_dir}/build"
cd $kernel_dir
make_a_fucking_defconfig() 
{
	make ARCH="arm64" O=$objdir $CONFIG_FILE -j8
}
compile() 
{
	make CC="${CLANG_TCHAIN}" O=$objdir -j8 Image.gz-dtb
}
ramdisk() 
{
	cd ${objdir}
	mv -f arch/arm64/boot/Image.gz-dtb $builddir/Image.gz-dtb
}
make_a_fucking_defconfig
compile 
ramdisk
cd ${kernel_dir}