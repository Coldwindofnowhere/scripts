#!/bin/bash
#Setup perl, aliases, cowsay and lolcat on android
 
IP='192.168.1.32'

# Assuming that if adb isn't running on wireless, the device is plugged and vice versa
if nc -z $IP 5555
then
    adb connect $IP && adb root && adb connect $IP
else 
    adb root
fi 

adb remount && adb shell "

mkdir /data/temp
cd /data/temp

# Install perl
if [ ! -d /data/local/perl ]
then
    busybox wget http://corion.net/perl-android/perl-5.22.0-armv7l-linux-android-5.0-20150828.tar.gz 
    busybox tar -xvf ./perl-5.22.0-armv7l-linux-android-5.0-20150828.tar.gz -C /data/local
    ln -s /data/local/perl/bin/perl5.22.0 /system/bin/perl
fi

# Custom mkshrc
wget -O mkshrc https://raw.githubusercontent.com/Coldwindofnowhere/scripts/master/android/mkshrc 

if cmp -s ./mkshrc /system/etc/mkshrc
then
    echo 'mkshrc is already up to date'
else 
    mv mkshrc /system/etc/mkshrc
fi

# Various (useful or not) binaries

wget -O cowsay https://github.com/Coldwindofnowhere/scripts/raw/master/android/binaries/cowsay
wget -O lolcat https://github.com/Coldwindofnowhere/scripts/raw/master/android/binaries/lolcat

mv cowsay /system/bin/cowsat
mv lolcat /system/bin/lolcat && chmod +x /system/bin/lolcat

# Remove temp directory
rm -rf /data/temp "