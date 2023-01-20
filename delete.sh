#!/bin/bash
echo "Which Table do you want to Delete from?"
filecount=$(ls -l | wc -l)
if (("$filecount" == 1)); then
    echo "DB dosen't contain any tables"
    cd ..
    ./connectDB.sh
else
    ls
fi
echo "Enter the table you want to Delete"
read tablename
if [[ -f $tablename ]]; then
    PS3="Please Choose a Number: "
    echo "please enter the SQL syntax as the following: delete from $tablename where {condition}."
    echo "delete from $tablename where"
    read colName
    # matching coulmn name
    if [ $(grep "$colName" ./.metaOF$tablename | wc -l) -eq 1 ]; then
        cname=$colName
    else
        echo "There is no Such Data to Delete"
        cd ..
        ./connectDB.sh
    fi
    echo "="
    read pdata
    #check data
    if [ $(grep "$pdata" $tablename | wc -l) -ge 1 ]; then
        data=$pdata
    else
        echo "There is no Such Data to Delete"
        cd ..
        ./connectDB.sh
    fi
    #$cname in .meta-> ColNum in file
    ColNum=$(awk -F: '{print $1,NR}' ./.metaOF$tablename | grep "$cname" | cut -d " " -f2)
    #$data -> RecNum in file
    RecNum=$(awk '{print NR,$ColNum}' ./$tablename | grep "$data" | cut -d " " -f1)
    #using -i to order sed to delete
    sed -i "$RecNum d" ./$tablename
    echo "Deleted Successfully"

    cd ..
    ./connectDB.sh

else
    echo "There is no Table with such Name"
    cd ..
    ./connectDB.sh
fi
