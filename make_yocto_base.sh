#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

cd poky
source oe-init-build-env
echo ""
echo "Starting creation of minimal Yocto image..."
echo "--------------------------------------------"
echo ""
bitbake -k core-image-full-cmdline
