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
        # touch ./$tablename
        touch ./.metaOF$tablename
        echo "Enter the Number of Columns"
        # read colsNum
        colsNum=$(whiptail --title "Create Table" --inputbox "Enter the Number of Columns " 8 45 3>&1 1>&2 2>&3)

        if [[ "$colsNum" =~ ^(1|2|3|4|5|6|7|8|9|10|11|12)$ ]]; then
            let noc=$colsNum
            let counter=$noc
        else
            whiptail --title "Create Table" --msgbox "Enter a Valid Number of Columns" 8 45
            echo "Enter a Valid Number of Columns"
            cd ..
            ./connectDB.sh
        fi
        while ((counter != 0)); do
            echo "Enter the Columns Name: "
            # read colName
            colName=$(whiptail --title "Create Table" --inputbox "Enter the Columns Name " 8 45 3>&1 1>&2 2>&3)
            if [[ $colName =~ ^[a-zA-Z]+$ ]]; then

                if [ $(grep "$colName" .metaOF$tablename | wc -l) -eq 1 ]; then
                    whiptail --title "Create Table" --msgbox "it must be unique!" 8 45
                    echo "it must be unique!"
                    rm -r .metaOF$tablename
                    cd ..
                    ./connectDB.sh
                else
                    cn=$colName
                fi
                echo "Enter the Data Type (S|s) for string (I|i) for integar):  "
                # read colDataType
                colDataType=$(whiptail --title "Create Table" --inputbox "Enter the Data Type (S|s) for string (I|i) for integar) " 8 45 3>&1 1>&2 2>&3)
                if [[ "$colDataType" =~ ^(S|s)$ ]]; then
                    cdt=$colDataType
                elif [[ "$colDataType" =~ ^(I|i)$ ]]; then
                    cdt=$colDataType
                else
                    echo "Enter a Valid Data Type"
                    whiptail --title "Create Table" --msgbox "Enter a Valid Data Type" 8 45
                    rm -r .metaOF$tablename
                    cd ..
                    ./connectDB.sh
                fi
                echo "is this colums pk? (pk -> if it a primary key /notpk -> if it is not a primary key) "
                # read isColPK
                isColPK=$(whiptail --title "Create Table" --inputbox "is this colums pk? (pk -> if it a primary key /notpk -> if it is not a primary key)" 8 45 3>&1 1>&2 2>&3)

                if [[ "$isColPK" =~ ^(pk)$ ]]; then
                    if [ $(grep "pk$" .metaOF$tablename | wc -l) -eq 1 ]; then
                        whiptail --title "Create Table" --msgbox "there is a PK for this table" 8 45
                        echo "there is a PK for this table"
                        rm -r .metaOF$tablename
                        cd ..
                        ./connectDB.sh
                    else
                        ispk=$isColPK
                    fi
                elif [[ "$isColPK" =~ ^(notpk)$ ]]; then
                    ispk=$isColPK
                else
                    whiptail --title "Create Table" --msgbox "Choose a valid Answer" 8 45
                    echo "Choose a valid Answer"
                    rm -r .metaOF$tablename
                    cd ..
                    ./connectDB.sh
                fi
                let counter=counter-1
            fi
            #enter metadata
            echo "$cn:$cdt:$ispk" >>./.metaOF$tablename
        done
        touch ./$tablename
        # touch ./.metaOF$tablename
        whiptail --title "Create Table" --msgbox "Table Created Successfully" 8 45
        echo "Table Created Successfully"
        cd ..
        ./connectDB.sh
    fi
else
    whiptail --title "Create Table" --msgbox "Enter a Valid Name for The Table" 8 45
    echo "Enter a Valid Name for The Table"
    cd ..
    ./connectDB.sh
fi
