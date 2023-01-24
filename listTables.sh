#! /bin/bash

filecount=$(find . -not -path '*/.*' | wc -l)

if (($filecount == 0)); then
whiptail --title "List Table" --msgbox "No Tables Found" 8 45
echo "No Tables Found"
else
whiptail --title "List Tables" --msgbox "$(ls)" 8 45
echo "Tables:"
ls
fi

cd ..
./connectDB.sh
