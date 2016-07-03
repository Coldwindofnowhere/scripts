#!/bin/bash

name='"Coldwindofnowhere"'
mail="coldwindofnowhere@gmail.com"

#Installs all dependencies required to build android stuff on debian based distros

sudo apt-get install openjdk-8-jdk git-core git-svn gnupg flex bison gperf build-essential \
zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 pkg-config \
lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
libgl1-mesa-dev libxml2-utils xsltproc unzip bc ccache libmpc-dev libmpfr-dev \
binfmt-support libllvm-3.6-ocaml-dev llvm-3.6 llvm-3.6-dev llvm-3.6-runtime libcap-dev \
cmake automake autogen autoconf autotools-dev libtool shtool python m4 libtool zlib1g-dev

#I don't think i'm forgetting anything, right ?

#Setup USB access
if [ ! -f /etc/udev/rules.d/51-android.rules ]
then
	wget -S -O - http://source.android.com/source/51-android.rules | sed "s/<username>/$USER/" | sudo tee >/dev/null /etc/udev/rules.d/51-android.rules; sudo udevadm control --reload-rules
else
	echo "USB access already configured"
fi

#Use ccache
echo "export USE_CCACHE=1" | sudo tee --append ~/.bashrc

#Install repo in /usr/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
chmod a+x /usr/bin/repo

#Configure git
git config --global user.name $name
git config --global user.email $mail
