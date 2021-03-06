# rpi4-crosstool
Config files for crosstool-ng to build 3 cross toolchains for the Raspberry Pi 4

## Background

I was trying to get a reasonable cross-toolchain for my Raspberry Pi 4, and the sample projects that
came with crosstool-ng weren't building. So, after some trial and error I came up with configurations
for three toolchains:  
* arm-rpi4-linux-gnueabi  
  Basic 32-bit toolchain
* arm-rpi4-linux-gnueabihf  
  32-bit toolchain with hard-float specifically called out
* aarch64-rpi4-linux-gnueabihf  
  64-bit toolchain with hard-float. For executables built with this toolchain to work on your Pi,
  you need a full 64-bit OS (both kernel and userspace). The standard Raspian has 64-bit kernel,
  but userspace programs compile to 32-bit executables.

## Usage

### Get the latest crosstool-ng:
```bash
$ git clone https://github.com/crosstool-ng/crosstool-ng.git crosstool-ng
$ cd crosstool-ng
$ ./bootstrap
$ ./configure --prefix=${PWD}
$ make
```

### Copy one of the config.* files to .config:

* config.aarch64-rpi4-linux-gnueabihf
* config.arm-rpi4-linux-gnueabi
* config.arm-rpi4-linux-gnueabihf

<br>

### Build
Update the current config using your new .config as base, and build the toolchain.  
Note that the cross toolchain is built in `${USER}/x-tools` by default

```bash
$ ct-ng oldconfig
$ ct-ng build
```

Once the toolchain is built, you can use the following commands to set up for usage (assuming arm-rpi4-linux-gnueabihf toolchain):
```bash
$ export XTOOLS_TOP_DIR="/home/${USER}/x-tools"
$ export CROSS_COMPILE="arm-rpi4-linux-gnueabihf"
$ export CCPREFIX="${XTOOLS_TOP_DIR}/${CROSS_COMPILE}/bin/${CROSS_COMPILE}-"
```

## Try it out
Go to `/home/${USER}/x-tools` and build hello_world.c:
```bash
$ cd /home/${USER}/x-tools
$ ./arm-rpi4-linux-gnueabihf/bin/arm-rpi4-linux-gnueabihf-gcc hello_world.c -o hello_world
```
Copy `hello_world` to your Pi and run it.

---
