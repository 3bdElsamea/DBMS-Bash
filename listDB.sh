#! /bin/bash

subdircount=$(find `pwd` -maxdepth 1 -type d | wc -l)

if [ $subdircount -eq 0 ]
then
	whiptail --title "List Databases" --msgbox "No Databases Found" 8 45
	echo "No Databases Found"
	./run.sh
else
	whiptail --title "List Databases" --msgbox $(ls -F | grep /) 8 45	
	ls -F | grep /
	./run.sh
fi

