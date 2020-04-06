#!/bin/bash

###################################################################
#Script Name	:   build-gcc                                                                                           
#Description	:   build gcc for the SuperH2 toolchain   
#Date           :   samedi, 4 avril 2020                                                                          
#Args           :   Welcome to the next level!                                                                                        
#Author       	:   Jacques Belosoukinski (kentosama)                                                   
#Email         	:   kentosama@genku.net                                          
##################################################################

VERSION="9.3.0"
ARCHIVE="gcc-${VERSION}.tar.xz"
URL="https://gcc.gnu.org/pub/gcc/releases/gcc-${VERSION}/${ARCHIVE}"
SHA512SUM="4b9e3639eef6e623747a22c37a904b4750c93b6da77cf3958d5047e9b5ebddb7eebe091cc16ca0a227c0ecbd2bf3b984b221130f269a97ee4cc18f9cf6c444de"
DIR="gcc-${VERSION}"

# Check if user is root
if [ ${EUID} == 0 ]; then
    echo "Please don't run this script as root"
    exit
fi

# Create build folder
mkdir -p ${BUILD_DIR}/${DIR}

cd ${DOWNLOAD_DIR}

# Download gcc if is needed
if ! [ -f "${ARCHIVE}" ]; then
    wget ${URL}
fi

# Extract gcc archive if is needed
if ! [ -d "${SRC_DIR}/${DIR}" ]; then
    if [ $(sha512sum ${ARCHIVE} | awk '{print $1}') != ${SHA512SUM} ]; then
        echo "SHA512SUM verification of ${ARCHIVE} failed!"
        exit
    else
        tar xf ${ARCHIVE} -C ${SRC_DIR}
    fi
fi

cd ${SRC_DIR}/${DIR}

echo ${PWD}

# Download prerequisites
./contrib/download_prerequisites

cd ${BUILD_DIR}/${DIR}

# Configure before build
${SRC_DIR}/${DIR}/configure --prefix=${INSTALL_DIR}                        \
                            --build=${BUILD_MACH}                       \
                            --host=${HOST_MACH}                         \
                            --target=${TARGET}                          \
                            --program-prefix=${PROGRAM_PREFIX} \
                            --with-multilib-list=m2 \
                            --with-cpu=m2 \
                            --with-newlib \
                            --with-gnu-ld \
                            --with-gnu-as \
                            --with-gcc \
                            --without-headers \
                            --without-included-gettext \
                            --enable-lto \
                            --enable-languages=c,c++ \
                            --disable-threads \
                            --disable-libmudflap \
                            --disable-libgomp \
                            --disable-nls \
                            --disable-werror \
                            --disable-libssp \
                            --disable-shared \
                            --disable-libgcj \
                            --disable-libstdcxx \ 

# build and install gcc
make -j${NUM_PROC}

# Install
if [ $? -eq 0 ]; then
    make install
    make -j${NUM_PROC} all-target-libgcc
    make install-target-libgcc
fi


