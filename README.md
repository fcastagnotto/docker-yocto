# docker-yocto
First try of build os yocto-based using docker image

F.Castagnotto


## setup

1. Install docker on your machine following the [official docker guide](https://docs.docker.com/install/).
2. Execute the file **setup_env.sh** and wait till the end of the execution.
3. At the end, you can find the final images under *poky/build/tmp/deploy/images*

----------------------------------------------------------------------------------------------------------------------------------------

[2018.03.29] File "setup_env.sh" start creation of environment into a docker container (ubuntu 14.04) and create the Qemu Virtual Image

[2018.03.29] Fix missing LANG configuration. Creation of full virtual image, instead of minimal.
