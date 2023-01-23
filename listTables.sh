#! /bin/bash

filecount=$(find . -not -path '*/.*' | wc -l)
                
if (( $filecount == 0 ))
then
	echo "No Tables Found"
	whiptail --title "List Tables" --msgbox "No Tables Found" 8 45
else
	find . -maxdepth 1 -not -path '*/.*' -type f
	whiptail --title "List Tables" --msgbox $(find . -maxdepth 1 -not -path '*/.*' -type f) 8 45	
	
fi

cd .. 
./connectDB.sh
