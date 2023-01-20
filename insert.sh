#!/bin/bash
echo "Which Table do you want to insert Data into"
filecount=$(ls -l | wc -l)
if (("$filecount" == 1)); then
    echo "There is No Available Tables"
    cd ..
    ./connectDB.sh
else
    ls
fi
echo "Enter Table Name to insert into"
read tablename
if [[ -f $tablename ]]; then
    numOfCols=$(sed -n '$=' ./.metaOF$tablename)
    let recsNum=1
    while (($numOfCols != 0)); do
        colName=$(sed -n "$recsNum p" ./.metaOF$tablename | cut -d: -f1)
        colDataType=$(sed -n "$recsNum p" ./.metaOF$tablename | cut -d: -f2)
        isPK=$(sed -n "$recsNum p" ./.metaOF$tablename | cut -d: -f3)
        echo "Enter the  $colName Value | Data Type is $colDataType and is $isPK: "
        read colData
        #Validate the PK to be Unique
        for i in $(awk '{print $1}' ./$tablename); do
            if [[ "$isPK" =~ ^(pk)$ ]]; then
                if (($colData == $i)); then
                    echo "PK Must be Unique"
                    cd ..
                    ./connectDB.sh
                fi
            fi
        done
        #check data entred if it in the same datatype as the coulmn
        if [[ "$colDataType" =~ ^(I|i)$ && $colData =~ ^[0-9]+$ ]]; then
            data=$colData
        elif [[ "$colDataType" =~ ^(S|s)$ && $colData =~ ^[a-zA-Z]+$ ]]; then
            data=$colData
        else
            echo "Wrong Data Type"
            cd ..
            ./connectDB.sh
        fi
        let recsNum=recsNum+1
        numOfCols=$numOfCols-1
        #enter data to table file, -n for not going in newline, " " is the delimitter
        echo -n "$data " >>./$tablename
    done
    #printing a new line so next value of data get it's own line
    echo " " >>./$tablename
    echo "Data Inserted"
    cd ..
    ./connectDB.sh

else
    echo "Table does not Exsits"
    cd ..
    ./connectDB.sh
fi
