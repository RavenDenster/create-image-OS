#!/bin/bash

set -e

if [ "$1" == "build" ]; then
    git checkout -t origin/kirkstone -b my-branch
    source oe-init-build-env

    bitbake-layers create-layer ../meta-mylayer
    
    cd ..
    LAYER_PATH=$(pwd)/meta-mylayer
    PATH_COMPILATION=/home/ravendexter/poky/build/tmp/work/core2-64-poky-linux/helloyadro/1.0-r0
    cd build

    bitbake-layers add-layer ../meta-mylayer

    mkdir -p $LAYER_PATH/recipes-example/helloyadro

    cat <<EOF > $LAYER_PATH/recipes-example/helloyadro/helloyadro.bb
SUMMARY = "Hello Yadro program"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://../../../../../../../meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "file://helloyadro.c"

S = "/home/ravendexter/poky/build/tmp/work/core2-64-poky-linux/helloyadro/1.0-r0/build"

do_compile() {
        gcc -g -lm ${PATH_COMPILATION}/helloyadro.c -o ${PATH_COMPILATION}/build/helloyadro
}

do_install() {
        install -d ${PATH_COMPILATION}/image/usr/bin
        install -m 0755 ${PATH_COMPILATION}/build/helloyadro ${PATH_COMPILATION}/image/usr/bin/ 
}
EOF

    mkdir -p $LAYER_PATH/recipes-example/helloyadro/files
    
    cat <<EOF > $LAYER_PATH/recipes-example/helloyadro/files/helloyadro.c
#include <stdio.h>

int main() {
    printf("Hello from my own program!\n");
    return 0;
}
EOF

    bitbake-layers show-layers

    bitbake core-image-minimal

    bitbake helloyadro

elif [ "$1" == "run" ]; then
    "./scripts/runqemu" "./build/tmp/deploy/images/qemux86-64" "slirp" "nographic"
elif [ "$1" == "bash" ]; then
    bash
else
    echo "Использование: $0 {build|run}"
    exit 1
fi 