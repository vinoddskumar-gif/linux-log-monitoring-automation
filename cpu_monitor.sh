#!/bin/bash
echo "=================Script for checking CPU usage ========"
echo
echo


usage=$(mpstat 1 1 | awk '/Average/ {print $NF}' )
CPU=$(echo "100 - $usage" | bc)
echo "CPU idle : $usage %"
echo "CPU used : $CPU %"

if (( $(echo "$CPU > 90" | bc -l) ))
then 
	echo "STATUS : CRITICAL"
	echo " Top CPU consuming processes"
	ps -eo pid,user,cmd,%cpu --sort=-%cpu | head -5
	echo
	echo

elif (( $(echo "$CPU > 75" | bc -l)))
then 
	echo " STATUS : HIGH"
	echo " Top CPU consuming processes"
        ps -eo pid,user,cmd,%cpu --sort=-%cpu | head -5
	echo
	echo

elif (( $(echo "$CPU > 60" | bc -l)))
then
	echo " STATUS : WARNING "
else
	echo " STATUS : OK"
fi

