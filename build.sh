################################################################################
# build.sh
#  Helper script to build hello_world for RPi4
#
# Author: J. Parziale
# Date: 29 Aug 2021
################################################################################

export XTOOLS_TOP_DIR="/home/${USER}/x-tools"
cd ${XTOOLS_TOP_DIR}

export CROSS_COMPILE="arm-rpi4-linux-gnueabihf"
#export CROSS_COMPILE="grm-rpi4-linux-gnueabi"
#export CROSS_COMPILE="aarch64-rpi4-linux-gnueabihf"

export CCPREFIX="${XTOOLS_TOP_DIR}/${CROSS_COMPILE}/bin/${CROSS_COMPILE}-"

#./${CROSS_COMPILE}/bin/${CROSS_COMPILE}-gcc hello_world.c -o hello_world-${CROSS_COMPILE}

# Build hello_world for all available cross-compile toolchains under this directory.
for xc in $(find .  -mindepth 1 -maxdepth 1 -type d | sed -e "s|\.\/||g"); do
    echo "${XTOOLS_TOP_DIR}/${xc}/bin/${xc}-gcc hello_world.c -o hello_world-${xc}"
    ./${xc}/bin/${xc}-gcc hello_world.c -o hello_world-${xc}
done
