#!/bin/bash
#
# vers.1.5

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


cd poky
sed -i '/sanity/ s/^#*/#/' meta/conf/sanity.conf

source oe-init-build-env $1
touch conf/sanity.conf


case $1 in
	base-build)
		echo "Starting creation of Qemu virtual Yocto image..."
		;;

	rpi-build|rpi-docker-build)
		if [[ -z `cat conf/bblayers.conf| grep meta-oe` ]];then
			if [[ ! -d  meta-openembedded ]];then
				cd /yocto/poky
				git clone git://git.openembedded.org/meta-openembedded
			fi
			cd meta-openembedded
  			git checkout -b rocko origin/rocko
  			cd /yocto/poky/$1
			sed -i '/BBLAYERS ?= \" /a \/yocto\/poky\/meta-openembedded\/meta-oe \\' conf/bblayers.conf
		fi
		if [[ -z `cat conf/bblayers.conf| grep meta-python` ]];then
			if [[ ! -d  openembedded-core ]];then
				cd /yocto/poky
  				git clone git://git.openembedded.org/openembedded-core
  			fi
  			cd openembedded-core
  			git checkout -b rocko origin/rocko
  			cd /yocto/poky/$1
  			sed -i '/BBLAYERS ?= \" /a \/yocto\/poky\/meta-openembedded\/meta-python \\' conf/bblayers.conf
  		fi
  		if [[ -z `cat conf/bblayers.conf| grep openembedded-core/meta` ]];then
  			if [[ ! -d  openembedded-core ]];then
  				cd /yocto/poky
  				git clone git://git.openembedded.org/openembedded-core
  			fi
  			cd openembedded-core
  			git checkout -b rocko origin/rocko
  			cd /yocto/poky/$1
  			sed -i '/BBLAYERS ?= \" /a \/yocto\/poky\/openembedded-core\/meta \\' conf/bblayers.conf
  		fi
  		if [[ -z `cat conf/bblayers.conf| grep meta-raspberrypi` ]];then
  			if [[ ! -d  meta-raspberrypi ]];then
  				cd /yocto/poky
  				git clone git://git.yoctoproject.org/meta-raspberrypi
  			fi
  			cd meta-raspberrypi
  			git checkout -b rocko origin/rocko
  			cd /yocto/poky/$1
  			sed -i '/BBLAYERS ?= \" /a \/yocto\/poky\/meta\-raspberrypi \\' conf/bblayers.conf
  		fi
  		if [[ -z `cat conf/bblayers.conf| grep \"raspberrypi\"` ]];then
			echo "BBFILE_COLLECTIONS += \"raspberrypi\"" >> conf/bblayers.conf
		fi
		if [[ -z `cat conf/local.conf| grep openssh` ]];then
			echo "CORE_IMAGE_EXTRA_INSTALL += \"openssh\"" >> conf/local.conf
		fi
		if [[ -z `cat conf/local.conf| grep raspberrypi` ]];then
			echo "MACHINE ?= \"raspberrypi\"" >> conf/local.conf
		fi



		if [[ $1 == "rpi-build" ]];then
			echo "Starting creation of Raspberry PI Yocto image..."
		else
			if [[ -z `cat conf/bblayers.conf| grep meta-networking` ]];then
				sed -i '/BBLAYERS ?= \" /a \/yocto\/poky\/meta-openembedded\/meta-networking \\' conf/bblayers.conf
			fi
			if [[ -z `cat conf/bblayers.conf| grep meta-filesystems` ]];then
				sed -i '/BBLAYERS ?= \" /a \/yocto\/poky\/meta-openembedded\/meta-filesystems \\' conf/bblayers.conf
			fi
			if [[ -z `cat conf/bblayers.conf| grep meta-virtualization` ]];then
				if [[ ! -d meta-virtualization ]];then
					cd /yocto/poky
					git clone git://git.yoctoproject.org/meta-virtualization
				fi
				cd meta-virtualization
				git checkout -b rocko origin/rocko
				cd /yocto/poky/$1
				sed -i '/BBLAYERS ?= \" /a \/yocto\/poky\/meta-virtualization \\' conf/bblayers.conf
			fi
			if [[ -z `cat conf/local.conf| grep 'docker\|docker-contrib'` ]];then
				echo "CORE_IMAGE_EXTRA_INSTALL += \"  docker docker-contrib connman connman-client \"" >> conf/local.conf
			fi

			useradd developer &
			chown developer:developer /yocto/poky -R
			su developer

			echo "Starting creation of Raspberry PI Yocto image with Docker..."
		fi
		;;
esac

echo "--------------------------------------------"
echo ""
#bitbake -f -k core-image-full-cmdline
bitbake -f -k core-image-base


if [[ $1 == "rpi-build" ]]||[[ $1 == "rpi-docker-build" ]];then
	echo "----------------------------------------------------------------------------"
	echo "End of creation of Yocto Image!"	
	echo "If the creation of the Yocto image didn't return any error, your image is:"
	echo "   tmp/deploy/images/raspberrypi/core-image-base-raspberrypi.rpi-sdimg"
	echo "Just burn it on a SDcard using DD and enjoy!  ;-)"
	echo "----------------------------------------------------------------------------"
else
	echo "----------------------------------------------------------------------------"
	echo "End of creation of Yocto Image!"
	echo "If the creation of the Yocto image didn't return any error, your image into:"
	echo "   tmp/deploy/images/"
	echo "----------------------------------------------------------------------------"	
fi
