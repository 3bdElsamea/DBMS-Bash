#!/bin/bash
echo "Enter the Name of the Table"
read tablename
if [[ $tablename =~ ^[a-zA-Z]+$ ]]; then
    if [[ -f $tablename ]]; then
        echo "Table already Exsits"
        cd ..
        ./connectDB.sh
    else
        echo "Creating the Table"
        touch ./$tablename
        touch ./.metaOF$tablename
        echo "Enter the Number of Columns"
        read colsNum
        if [[ "$colsNum" =~ ^(1|2|3|4|5|6|7|8|9|10|11|12)$ ]]; then
            let noc=$colsNum
            let counter=$noc
        else
            echo "Enter a Valid Number of Columns"
            cd ..
            ./connectDB.sh
        fi
        while ((counter != 0)); do
            echo "Enter the Columns Name: "
            read colName
            if [[ $colName =~ ^[a-zA-Z]+$ ]]; then

                if [ $(grep "$colName" .metaOF$tablename | wc -l) -eq 1 ]; then
                    echo "it must be unique!"
                    cd ..
                    ./connectDB.sh
                else
                    cn=$colName
                fi
                echo "Enter the Data Type (S|s) for string (I|i) for integar):  "
                read colDataType
                if [[ "$colDataType" =~ ^(S|s)$ ]]; then
                    cdt=$colDataType
                elif [[ "$colDataType" =~ ^(I|i)$ ]]; then
                    cdt=$colDataType
                else
                    echo "Enter a Valid Data Type"
                    cd ..
                    ./connectDB.sh
                fi
                echo "is this colums pk? (pk -> if it a primary key /notpk -> if it is not a primary key) "
                read isColPK
                if [[ "$isColPK" =~ ^(pk)$ ]]; then
                    if [ $(grep "pk$" .metaOF$tablename | wc -l) -eq 1 ]; then
                        echo "there is a PK for this table"
                        cd ..
                        ./connectDB.sh
                    else
                        ispk=$isColPK
                    fi
                elif [[ "$isColPK" =~ ^(notpk)$ ]]; then
                    ispk=$isColPK
                else
                    echo "Choose a valid Answer"
                    cd ..
                    ./connectDB.sh
                fi
                let counter=counter-1
            fi
            #enter metadata
            echo "$cn:$cdt:$ispk" >>./.metaOF$tablename
        done
        echo "Table Created Successfully"
        cd ..
        ./connectDB.sh
    fi
else
    echo "Enter a Valid Name for The Table"
    cd ..
    ./connectDB.sh
fi
