#!/bin/bash
#
# v.0.7


echo "start docker daemon before!"


if [[ ! -z `docker images| grep step.22` ]];then

	exit_loop=0
	while [ $exit_loop == 0 ]; do

		echo "Select type of build: "
		echo "1 - standard image for Quemu"
		echo "2 - image for RaspberryPI"
		#echo "3 - image for RaspberryPI with docker"
		echo "x - exit"
		read -n 1 input
	
		case $input in
			1)
			param="base-build"
			exit_loop=1
			;;

			2)
			param="rpi-build"
			exit_loop=1
			;;
			
			3)
			param="rpi-docker-build"
			exit_loop=1
			;;

			x)
			exit 0
			;;
			*)
			echo "INPUT NOT ALLOWED!"
			sleep 2
			;;
		esac
	done


	docker run -it --volume `pwd`:/yocto -w /yocto/ -t yocto:step.22 bash -c "./build.sh ${param}"
	
else
	echo "Missing container image step.22!!"
fi
