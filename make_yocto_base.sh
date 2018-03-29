#!/bin/bash

source oe-init-build-env
echo ""
echo "Starting creation of minimal Yocto image..."
echo "--------------------------------------------"
echo ""
bitbake -k core-image-minimal
