#!/bin/bash
#Automatize android builds
#Usage: ./build.sh [rom|kernel|clean]


RED=`tput setaf 1`
GREEN=`tput setaf 2`
NC=`tput sgr0`

source build/envsetup.sh

#Put your device codename here
device="galaxysmtd"

#Check if ./logs exists, if not create it
if [ ! -d "logs" ]; then
	mkdir logs
fi


case "$1" in
	"rom") echo -e "\nBuilding the rom ...\n"

		#Builds the rom and redirect the output in ./logs
		brunch $device | tee logs/$1-$device-$(date +%Y%m%d).log
		out=$(ls -tr ./out/target/product/$device/*.zip | head -1)

		#Check MD5 of the output file
		md5=($(md5sum $out|awk '{print $1;}') $(cat $out.md5sum|awk '{print $1;}'))
		if [ ${md5[0]} = ${md5[1]} ]; then
			echo "${GREEN}MD5 matched !${NC}"
		else 
			echo -e "${RED}There might be a problem with MD5 : ${NC}\n ${md5[*]}"
		fi
			;;

	"kernel") echo -e "\nBuilding the kernel ...\n" 

		breakfast $device
		#Builds the kernel and redirect the output in ./logs
		mka bootimage | tee logs/$1-$device-$(date +%Y%m%d).log	
		out="./out/target/product/$device/boot.img"

		#Show MD5
		echo "MD5: $(md5sum $out|awk '{print $1;}')" ;;

	"clean") echo -e "\nCleaning the output and the cache ...\n"

	       make clean && ccache -C

	       #Show remaining free space
	       echo "$(($(stat -f --format="%a*%S" .)/2**30)) GiB of free space remaining" ;;

	*) echo "Invalid option"
esac
