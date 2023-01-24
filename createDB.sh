#!/bin/bash
# echo Enter DB Name
# read dbname
dbname=$(whiptail --title "Create Database" --inputbox "Enter Database Name: " 8 45 3>&1 1>&2 2>&3)
if [[ $dbname =~ ^[a-zA-Z]+$ ]]; then

    if [[ -d $dbname ]]; then
        whiptail --title "Create Databse" --msgbox "This Name already Exsits" 8 45
        echo "This Name already Exsits"
        ./run.sh
    else
        mkdir $dbname
        whiptail --title "Create Databse" --msgbox "DataBase created Successfully" 8 45
        echo "DB created Successfully"
        ./run.sh
    fi

else
    whiptail --title "Create Databse Message" --msgbox "You Must Enter a Valid Name" 8 45
    echo "You Must Enter a Valid Name."
    ./run.sh

fi
