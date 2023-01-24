#!/bin/bash

filecount=$(ls -l | wc -l)
if (("$filecount" == 0)); then
    echo "There are no tables in this Database"
    whiptail --title "Tables" --msgbox "There are No Available Tables" 8 45
    cd ..
    ./connectDB.sh

else
    # echo "Available tables: "
    # whiptail --title "Select" --msgbox $(ls) 8 45
    # ls

    echo "Please enter a table name"
    tablename=$(whiptail --title "Select" --inputbox "Enter Table Name to Select from" 8 45 3>&1 1>&2 2>&3)

    if [[ -f $tablename ]]; then
        ###e.g if table does exists
        menu=$(whiptail --title "Select Operation" --fb --menu "Choose an option" 15 60 4 \
            "1" "Select All Records" \
            "2" "Select All Where" \
            "3" "Exit" 3>&1 1>&2 2>&3)
        case $menu in
        1)
            echo "Select * from $tablename"
            #using this command to make a header for the table, tr replaces \n to " " e.g new line to space

            # whiptail --title "Insert" --msgbox $(awk -F: '{print $1}' ./.metaOF$tablename | tr -s '\n ' ' ') 8 45
            # awk -F: '{print $1}' ./.metaOF$tablename | tr -s '\n ' ' '
            # #echo to add anew line after the header
            # echo

            whiptail --title "Select * from $tablename" --textbox "$tablename" 12 45
            # cat $tablename
            cd ..
            ./connectDB.sh
            ;;
        2)
            echo "select * from $tablename where"
            pcname=$(whiptail --title "Select * from $tablename where" --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
            #check data
            # check in the file about matching coulmn name
            if [ $(grep "$pcname" ./.metaOF$tablename | wc -l) -eq 1 ]; then
                #what happends
                cname=$pcname
            else
                echo "it does not exist!"
                whiptail --title "Select * from $tablename where" --msgbox "Not found" 8 45
                cd ..
                ./connectDB.sh
            fi
            echo "Enter Value"
            pdata=$(whiptail --title "Select * from $tablename where" --inputbox "Enter Value" 8 45 3>&1 1>&2 2>&3)
            #check data if it exists in the coulmn or not
            if [ $(grep "$pdata" $tablename | wc -l) -ge 1 ]; then
                #what happends
                data=$pdata
            else
                whiptail --title "Select * from $tablename where" --msgbox "No records found" 8 45
                echo "No records found"

                cd ..
                ./connectDB.sh
            fi

            #$cname in .meta-> ColNum in file
            ColNum=$(awk -F: '{print $1,NR}' ./.metaOF$tablename | grep "$cname" | cut -d " " -f2)

            #$data -> RecNum in file
            RecNum=$(awk '{print NR,$ColNum}' ./$tablename | grep "$data" | cut -d " " -f1)

            #printing
            Rec=$(sed -n "$RecNum p" ./$tablename)
            echo here you go!
            #using this command to make a header for the table, tr replaces \n to " " e.g new line to space
            awk -F: '{print $1}' ./.metaOF$tablename | tr -s '\n ' ' '
            #echo to add anew line after the header
            whiptail --title "Select * from $tablename where" --msgbox "$Rec" 8 45
            echo

            echo $Rec
            #returning back!
            cd ..
            ./connectDB.sh
            ;;
        *)
            whiptail --title "Select from $tablename" --msgbox "Please try again and enter only numbers from 1 to 2!" 8 45
            echo "please try again and enter only numbers from 1 to 2!"
            ;;
        esac
    else
        ###e.g if table does not exists
        whiptail --title "Select from $tablename" --msgbox "Please enter a valid name" 8 45
        echo please enter a valid name!
        cd ..
        ./connectDB.sh
    fi
fi
