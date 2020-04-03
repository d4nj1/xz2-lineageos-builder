#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
	lineageBranch="lineage-17.1"
else
	lineageBranch=$1
fi

if [ -z "$2" ]; then
	scriptsBranch="android-10"
else
	scriptsBranch=$2
fi

# Fetch LineageOS

if [ ! -d ~/android/rom/lineageOS/10 ]; then
	mkdir -p ~/android/rom/lineageOS/10
	cd ~/android/rom/lineageOS/10
	repo init -u git://github.com/LineageOS/android.git -b $lineageBranch
	repo sync
else
	cd ~/android/rom/lineageOS/10
	repo sync
fi

# Fetch patched manifest

if [ ! -d ~/android/rom/lineageOS/10/.repo/local_manifests ]; then
	git clone https://github.com/MartinX3-AndroidDevelopment-LineageOS/local_manifests.git -b MartinX3/$lineageBranch ~/android/rom/lineageOS/10/.repo/local_manifests
else
	cd ~/android/rom/lineageOS/10/.repo/local_manifests
	git pull
fi

# Fetch build scripts

git clone https://github.com/MartinX3-AndroidDevelopment/SCRIPTS_BUILD.git -b $scriptsBranch ~/SCRIPTS_BUILD
chmod +x ~/SCRIPTS_BUILD/ROM/CUSTOM/XPERIA_TAMA/LineageOS/build.sh
cd ~/SCRIPTS_BUILD/ROM/CUSTOM/XPERIA_TAMA/LineageOS/

# Remove interactive input

sed -i 's|read -n1 -r -p "Press space to continue..."||g' ~/SCRIPTS_BUILD/ROM/CUSTOM/XPERIA_TAMA/LineageOS/build.sh

# Run build

./build.sh
