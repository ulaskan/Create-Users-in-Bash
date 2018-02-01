#!/bin/bash
# Author: Ulas Askan
# Date: 16 Oct 2016

clear
echo -e "Users being created from, $1 ..."
echo
IFSback=$IFS
IFS=","
i=1
while read userName homeDir userShell userInfo mainGroup tmpPass 
do 
	test $i -eq 1 && ((i=i+1)) && continue
	homeDir=$homeDir$userName	
	useradd -m -d "$homeDir" -s "$userShell" -c "$userInfo" -G "$mainGroup" "$userName"
	echo -e "${tmpPass}\n${tmpPass}" | passwd "$userName" 2> /dev/null
	chage -d 0 "$userName"
	echo	
done < $1
echo

IFS=$IFSback
