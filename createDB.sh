#!/bin/bash
echo Enter DB Name
read dbname
if [[ $dbname =~ ^[a-zA-Z]+$ ]]
then

if [[ -d $dbname ]] 
then
echo This Name already Exsits
./createDB.sh
else
mkdir $dbname
echo DB created Successfully
./run.sh
fi

else
echo You Must Enter a Valid Name.
./createDB.sh
fi

