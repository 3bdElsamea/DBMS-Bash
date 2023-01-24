#!/bin/bash

filecount=$(ls -l | wc -l)
if (("$filecount" == 0)); then
    echo " No Tables Found"
    cd ..
    ./connectDB.sh

else
    tablename=$(whiptail --title "Update Table" --inputbox "Enter Table Name to Update" 8 45 3>&1 1>&2 2>&3)
    echo "Enter Table Name to Update"
    if [[ -f $tablename ]]; then
        whiptail --title "Update" --msgbox "Syntax: update $tablename set {columnName}={value} where {condition}." 8 45
        psetcname=$(whiptail --title "Update Table" --inputbox "Column Name" 8 45 3>&1 1>&2 2>&3)
        echo "update $tablename set"

        if [ $(grep "$psetcname" ./.metaOF$tablename | wc -l) -eq 1 ]; then
            setcname=$psetcname
        else
            echo "Not found"
            cd ..
            ./connectDB.sh
        fi

        echo "="

        psetdata=$(whiptail --title "Update Table" --inputbox "=" 8 45 3>&1 1>&2 2>&3)

        cr=$(awk -F: '{print $1, NR}' ./.metaOF$tablename | grep "$setcname" | cut -d " " -f2)
        cdt=$(sed -n "$cr p" ./.metaOF$tablename | cut -d: -f2)
        ispk=$(sed -n "$cr p" ./.metaOF$tablename | cut -d: -f3)

        for i in $(awk '{print $1}' ./$tablename); do
            if [[ "$ispk" =~ ^(pk)$ ]]; then
                if (($psetdata == $i)); then
                    whiptail --title "Update" --msgbox "PK is not unique" 8 45
                    echo "PK is not unique"
                    cd ..
                    ./connectDB.sh
                fi
            fi
        done
        if [[ "$cdt" =~ ^(i)$ && $psetdata =~ ^[0-9]+$ ]]; then
            setdata=$psetdata
        elif [[ "$cdt" =~ ^(s)$ && $psetdata =~ ^[a-zA-Z]+$ ]]; then
            setdata=$psetdata
        else
            whiptail --title "Update" --msgbox "Wrong Type" 8 45
            echo "Wrong Type"
            cd ..
            ./connectDB.sh
        fi

        pcname=$(whiptail --title "Update" --inputbox "Where" 8 45 3>&1 1>&2 2>&3)
        echo "Where"
        if [ $(grep "$pcname" ./.metaOF$tablename | wc -l) -eq 1 ]; then
            cname=$pcname
        else

            whiptail --title "Update" --msgbox "Not Found" 8 45
            echo "Not Found"
            cd ..
            ./connectDB.sh
        fi

        pdata=$(whiptail --title "Update" --inputbox "=" 8 45 3>&1 1>&2 2>&3)
        echo "="
        if [ $(grep "$pdata" $tablename | wc -l) -ge 1 ]; then
            data=$pdata
        else
            whiptail --title "Update" --msgbox "Not Found" 8 45
            echo "Not Found"
            cd ..
            ./connectDB.sh
        fi

        ColNum=$(awk -F: '{print $1,NR}' ./.metaOF$tablename | grep "$cname" | cut -d " " -f2)
        RecNum=$(awk '{print NR,$ColNum}' ./$tablename | grep "$data" | cut -d " " -f1)

        setColNum=$(awk -F: '{print $1,NR}' ./.metaOF$tablename | grep "$setcname" | cut -d " " -f2)

        dataprev=$(awk '{print NR, $'"$setColNum"'}' ./$tablename | grep "$RecNum" | cut -d " " -f2)

        sed -i "$RecNum s/$dataprev/$setdata/" ./$tablename

        whiptail --title "Update" --msgbox "Done" 8 45
        cd ..
        ./connectDB.sh

    else
        whiptail --title "Update" --msgbox "Enter a Valid Name" 8 45
        echo "Enter a valid name"
        cd ..
        ./connectDB.sh
    fi
fi
