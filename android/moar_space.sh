#!/system/bin/sh
#Removes bloatware and frees some space on RR !

if ! [ $(id -u) = 0 ]; then
	echo "Run this script as root, or it will never work\n"
	exit
fi

mount -o rw,remount,rw /system

echo "Removing crap ...\n"

used=$(df -k /system | tail -1 | tr -s ' ' | cut -d' ' -f4)

rm -rf /system/app/{BasicDreams,Galaxy4,LiveWallpapers,HoloSpiralWallpaper,\
	NoiseField,PhaseBeam,PhotoPhase,PhotoTable,ResurrectionOTA,ResurrectionStats}

freed=$(($(df -k /system | tail -1 | tr -s ' ' | cut -d' ' -f4)-$used))

echo "Done, $freed bytes freed."
