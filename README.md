# xz2-lineageos-builder
This repository provides a Docker environment to build LineageOS for the Sony Xperia XZ2 device series

It uses a build script provided by MartinX3 which can be found in this [repository](https://github.com/MartinX3-AndroidDevelopment/SCRIPTS_BUILD).

#### Build Docker container for build runtime

`docker build --no-cache --force-rm --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t xz2-lineageos-builder:latest -f Dockerfile .`

#### Run LineageOS build in container

`docker run -ti -v $PWD/android:/home/developer/android -v $PWD/out:/home/developer/out xz2-lineageos-builder:latest`

This will pass the **android**, **cache** and **out** folder to the container which will reuse already downloaded repository and branch data and make the build result available to the host.

Optional you can pass branch name for LineageOS and scripts repositories like this:

`docker run -ti -v $PWD/android:/home/developer/android -v $PWD/out:/home/developer/out xz2-lineageos-builder:latest LINEAGE_BRANCH SCRIPTS_BRANCH`