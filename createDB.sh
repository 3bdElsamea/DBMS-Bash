#!/bin/bash
echo Enter DB Name
read dbname
if [[ $dbname =~ ^[a-zA-Z]+$ ]]; then

    if [[ -d $dbname ]]; then
        # whiptail --title "Create Databse" --msgbox "This Name already Exsits" 8 45
        echo This Name already Exsits
        ./createDB.sh
    else
        mkdir $dbname
        # whiptail --title "Create Databse" --msgbox "DataBase created Successfully" 8 45
        echo DB created Successfully
        ./run.sh
    fi

else
    # whiptail --title "Create Databse Message" --msgbox "You Must Enter a Valid Name" 8 45
    echo You Must Enter a Valid Name.
    ./createDB.sh

fi
