#!/bin/bash
# echo "Enter the Name of the Table"
# read tablename
tablename=$(whiptail --title "Create Table" --inputbox "Enter the Name of the Table" 8 45 3>&1 1>&2 2>&3)
if [[ $tablename =~ ^[a-zA-Z]+$ ]]; then
    if [[ -f $tablename ]]; then
        whiptail --title "Create Table" --msgbox "Table already Exsits" 8 45
        echo "Table already Exsits"
        cd ..
        ./connectDB.sh
    else
        echo "Creating the Table"
        touch ./.metaOF$tablename
        echo "Enter the Number of Columns"
        # read colsNum
        colsNum=$(whiptail --title "Create Table" --inputbox "Enter the Number of Columns " 8 45 3>&1 1>&2 2>&3)
        let noc=$colsNum
        counter=1
        pkFlag=1
        createFlag=1
        while [[ counter -le $noc ]]; do
            echo "Enter the Column Number $counter Name: "
            # read colName
            colName=$(whiptail --title "Create Table" --inputbox "Enter the Column Number $counter Name" 8 45 3>&1 1>&2 2>&3)
            if [[ $colName =~ ^[a-zA-Z]+$ ]]; then

                if [ $(grep "$colName" .metaOF$tablename | wc -l) -eq 1 ]; then
                    whiptail --title "Create Table" --msgbox "Column Named Must be Unique" 8 45
                    echo "it must be unique!"
                else
                    cn=$colName
                fi
                echo "Enter the Data Type (S|s) for string (I|i) for integar):  "
                # read colDataType
                colDataType=$(whiptail --title "Data Type Menu " --fb --menu "select Data Type" 15 60 4 \
                    "1" "Integer" \
                    "2" "String" \
                    3>&1 1>&2 2>&3)
                case $colDataType in
                1)
                    cdt="int"
                    ;;
                2)
                    cdt="str"
                    ;;
                esac
                ispk="notpk"
                if [[ pkFlag -eq 1 ]]; then
                    echo "is this colums pk? (pk -> if it a primary key /notpk -> if it is not a primary key) "
                    # read isColPK
                    isColPK=$(whiptail --title "Check Primary Key" --fb --menu "Is this Col Primary Key" 15 60 4 \
                        "1" "Yes" \
                        "2" "no" \
                        3>&1 1>&2 2>&3)
                    case $isColPK in
                    1)
                        ispk="pk"
                        pkFlag=0
                        ;;
                    2)
                        ispk="notpk"
                        ;;
                    esac
                fi
                let counter=counter+1
                echo "$cn:$cdt:$ispk" >>./.metaOF$tablename
            else
                whiptail --title "Create Table" --msgbox "Enter a Valid Name for The Column" 8 45
                echo "Enter a Valid Name for The Column"
            fi
        done
        whiptail --title "Create Table" --msgbox "Table Created Successfully" 8 45
        echo "Table Created Successfully"
        touch ./$tablename
        cd ..
        ./connectDB.sh
    fi
else
    whiptail --title "Create Table" --msgbox "Enter a Valid Name for The Table" 8 45
    echo "Enter a Valid Name for The Table"
    cd ..
    ./connectDB.sh
fi
