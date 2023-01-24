#! /bin/bash

dbname=$(whiptail --title "Connect to Database" --inputbox "Enter Database Name: " 8 45 3>&1 1>&2 2>&3)

if [[ -d $dbname ]] && [[ $dbname != "" ]]
then
	cd $dbname
	whiptail --title "Connect to Database" --msgbox "Connected to $dbname" 8 45
	echo "Connected to $dbname"
	dbMenu=$(whiptail --title "BDMS Menu" --fb --menu "Choose an option" 15 60 4 \
		"1" "Create Table" \
		"2" "List Tables" \
		"3" "Drop Table" \
		"4" "Insert Into Table" \
		"5" "Select From Table" \
		"6" "Delete From table" \
		"7" "Update table" \
		"8" "Exit" 3>&1 1>&2 2>&3)
		
	case $dbMenu in
		1)./../createTable.sh
		;;
		2)./../listTables.sh
		;;
		3)./../dropTable.sh
		;;
		4)./../insert.sh
		;;
		5)./../select.sh
		;;
		6)./../delete.sh
		;;
		7)./../updateTable.sh
		;;
		8)exit
		;;
		*)echo "please enter numbers from 1 to 8"
		;;
esac
else
	whiptail --title "Connect to Database" --msgbox "Enter a Valid Database" 8 45
	echo "Enter a Valid Database"
	./run.sh
fi
