#!/bin/bash
# echo Welcome to our DBMS
# PS3="Please Choose a Number: "
# select item in "Create DB" "List DB" "Connect to DB" "Drop DB" "Exit"; do
dbMenu=$(whiptail --title "BDMS Menu" --fb --menu "Choose an option" 15 60 4 \
	"1" "Create Database" \
	"2" "List Databases" \
	"3" "Conect to Database" \
	"4" "Drop Database" \
	"5" "Exit" 3>&1 1>&2 2>&3)
case $dbMenu in
# case $REPLY in
1)
	./createDB.sh
	;;
2)
	./listDB.sh
	;;
3)
	./connectDB.sh
	;;
4)
	./dropDB.sh
	;;
5)
	exit
	;;

esac

# done
