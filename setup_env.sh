#!/bin/bash

echo "Start in the same folder of 'Dockerfile'!"
sudo docker build -t yocto:step.22 ./container/
echo ""
echo "Created image yocto:step.22"
echo ""
echo "Cloning Yocto repo.."
git clone --progress --verbose git://git.yoctoproject.org/poky/
cd ./poky
git checkout -b rocko origin/rocko
cd ..
sed -i '/sanity/ s/^#*/#/' poky/meta/conf/sanity.conf

echo "starting container.."
echo ""

#docker run --volume `pwd`:/yocto -w /yocto/ -t yocto:step.22 bash -c "./make_yocto_base.sh"
docker run --volume `pwd`:/yocto -w /yocto/ -t yocto:step.22 bash -c "./build.sh standard"

echo ""
echo "Images ready."
echo "#################################"

exit 0
