#! /bin/bash

SYM_PATH=`pwd`"/symbol"
if [ -d ${SYM_PATH} ]; then
 echo "symbol downloaded"
 exit 0
fi

kernel_version=$(uname -r)
echo "Kernel version : ${kernel_version}"

kernel_pkg_version=$(dpkg -l | grep linux-modules-$(uname -r) | head -1 | awk '{ print $3; }')
echo "Kernel package version : ${kernel_pkg_version}"

pkg_name="linux-modules-${kernel_version}_${kernel_pkg_version}_amd64.deb"
pkg_uri="http://archive.ubuntu.com/ubuntu/pool/main/l/linux/${pkg_name}"
echo "Downloading package linux-modules at ${pkg_uri}"

mkdir -p symbols/${kernel_version}
cd symbols/${kernel_version}

wget ${pkg_uri} -O ${pkg_name}
mkdir -p extract
dpkg -x ${pkg_name} extract/

symbols_file="extract/boot/System.map-${kernel_version}"
if [ ! -f ${symbols_file} ]; then
	echo "Failed to extract symbol file. Check download of Ubuntu package"
	cd ../../
	rm -rf symbols
	cd - > /dev/null
	exit 1
else
	echo "Symbol file found. Cleaning directory..."
	mv ${symbols_file} ..
fi

cd - > /dev/null
rm -rf symbols/${kernel_version}
echo "Symbol file : System.map-${kernel_version}"
