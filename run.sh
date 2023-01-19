#!/bin/bash
echo Welcome to our DBMS
PS3="Please Choose a Number: "
select item in "Create DB" "List DB" "Connect to DB" "Drop DB" "Exit"
do
case $REPLY in
1)./createDB.sh
exit;;
2) ./listDB.sh
exit;;
3) ./connectDB.sh
exit;;
4) ./dropDB.sh
exit;;
5)
exit;;
*) echo "Please Enter Number from 1 to 5 only"
	./run.sh;;
esac

done

