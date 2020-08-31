# GCC toolchain for the Hitachi SuperH2

This is a set of bash scripts for build gcc toolchain on unix environment for the Hitachi SuperH2 (sh2) was used in **SEGA Saturn** and **32X**.

## Build the toolchain

First, you need to install devel environment was come with your Linux distro for build the toolchain. 

**ArchLinux**
```bash
$ sudo pacman -Syu
$ sudo pacman -S base-devel
```

**Debian**
```bash
$ sudo apt update
$ sudo apt install build-essential texinfo
```

**Ubuntu**
```bash
$ sudo apt update
$ sudo apt install build-essential texinfo
```

**Fedora**
```bash
$ sudo dnf update
$ sudo dnf groupinstall "Development Tools"
$ sudo dnf groupinstall "C Development Tools and Libraries"
```

After, going into your workspace where you want build the toolchain (for example ~/workspace/source) and clone this repository:

```bash
cd ~/workspace/source
git clone https://github.com/kentosama/sh2-elf-gcc.git
cd sh2-elf-gcc
```
Now, you can run **build-toolchain.sh** for start the build. The process should take approximately 15 min or several hours depending on your computer. **Please, don't run this script as root!**

```
$ ./buid-toolchain.sh
```

## Install

Once the SH2 toolchain was successful built, you can process to the installation. Move or copy the "sh2-toolchain" folder in "/opt" or "/usr/local":

```bash
$ sudo cp -R sh2-toolchain /opt
```

If you want, add the SH2 toolchain to your path environment:

```bash
$ echo export PATH="${PATH}:/opt/sh2-toolchain/bin" >> ~/.bash_rc
$ source ~/.bash_rc
```

Finally, check that sh2-elf-gcc is working properly:

```bash
$ sh2-elf-gcc -v
```

The result should display something like this:

```bash
Using built-in specs.
COLLECT_GCC=./sh2-elf-gcc
COLLECT_LTO_WRAPPER=/home/kentosama/workspace/sh-elf-gcc/toolchain/libexec/gcc/sh-elf/9.3.0/lto-wrapper
Target: sh-elf
Configured with: /home/kentosama/workspace/sh-elf-gcc/source/gcc-9.3.0/configure --prefix=/home/kentosama/workspace/sh-elf-gcc/toolchain --build=x86_64-pc-linux-gnu --host=x86_64-pc-linux-gnu --target=sh-elf --program-prefix=sh2-elf- --with-multilib-list=m2 --with-cpu=m2 --with-newlib --with-gnu-ld --with-gnu-as --with-gcc --without-headers --without-included-gettext --disable-nls --enable-lto --enable-languages=c,c++ --disable-threads --disable-libmudflap --disable-libgomp --disable-nls --disable-werror --disable-libssp --disable-shared --disable-multilib --disable-libgcj --disable-libstdcxx ' ' : (reconfigured) /home/kentosama/Workspace/sh-elf-gcc/source/gcc-9.3.0/configure --prefix=/home/kentosama/workspace/sh-elf-gcc/toolchain --build=x86_64-pc-linux-gnu --host=x86_64-pc-linux-gnu --target=sh-elf --program-prefix=sh2-elf- --with-multilib-list=m2 --with-cpu=m2 --with-newlib --with-gnu-ld --with-gnu-as --with-gcc --without-headers --without-included-gettext --disable-nls --enable-lto --enable-languages=c,c++ --disable-threads --disable-libmudflap --disable-libgomp --disable-nls --disable-werror --disable-libssp --disable-shared --disable-multilib --disable-libgcj --disable-libstdcxx ' '
Thread model: single
gcc version 9.3.0 (GCC)
```

For backup, you can store the SH2 toolchain in external drive:
```bash
$ tar -Jcvf sh2-gcc-9.3.0-toolchain.tar.xz sh2-toolchain
$ mv sh2-gcc-9.3.0-toolchain.tar.xz /storage/toolchains/
```
