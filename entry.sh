#!/bin/bash

set -e

if [ "$1" == "build" ]; then
    git checkout -t origin/kirkstone -b my-branch
    source oe-init-build-env

    bitbake-layers create-layer ../meta-mylayer
    
    cd ..
    LAYER_PATH=$(pwd)/meta-mylayer
    cd build

    bitbake-layers add-layer ../meta-mylayer
    ls

    mkdir -p $LAYER_PATH/recipes-example/helloyadro
    mkdir -p $LAYER_PATH/recipes-example/helloyadro/files

    cp -r ./prepare-files/helloyadro.bb $LAYER_PATH/recipes-example/helloyadro/
    cp -r  ./prepare-files/helloyadro.c $LAYER_PATH/recipes-example/helloyadro/files/
    
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