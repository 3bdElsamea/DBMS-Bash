#!/bin/bash

# echo "Enter the DB you want to delete"
# read dbname
dbname=$(whiptail --title "Drop Database" --inputbox "Enter Database Name: " 8 45 3>&1 1>&2 2>&3)
if [[ -d $dbname ]]; then
  rm -r $dbname
  whiptail --title "Drop Databse" --msgbox "DB Deleted Successfully" 8 45
  echo "DB Deleted"
  ./run.sh
else
  whiptail --title "Drop Databse" --msgbox "DB Dosen't Exist" 8 45
  echo "DB dosen't Exist."
  ./run.sh
fi
