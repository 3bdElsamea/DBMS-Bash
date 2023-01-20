#!/bin/bash
# dirCount=$(find $(pwd) -maxdepth 1 -type d | wc -l)
# if [[ $dirCount == 1 ]]; then
#   echo "There is no DB to delete."
#   . ./run.sh
# else
#   echo "Which DB do you want to Delete?"
#   ls -d */ | cut -f1 -d'/'
# fi

echo "Enter the DB you want to delete"
read dbname
if [[ -d $dbname ]]; then
  rm -r $dbname
  echo DB Deleted
  ./run.sh
else
  echo "DB dosen't Exist."
  ./run.sh
fi
