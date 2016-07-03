#!/bin/bash
#Useless script that prints each line of the piped output in a random color
#Usage: foo|./rainbow.sh

#Print each line in a different color
while read line 
do
	code=$((0 + RANDOM % 255))
	echo -e "\e[38;05;${code}m$line"
	read line	      
done

#Reset to defaut color
echo -en "\e[0m"
