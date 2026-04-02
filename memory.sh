#!/bin/bash

echo "================= Memory Usage Check ================="
echo

# Get memory values in MB
total_mem=$(free -m | awk 'NR==2 {print $2}')
avail_mem=$(free -m | awk 'NR==2 {print $7}')

# Calculate memory usage percentage
used_mem=$(echo "scale=2; ($total_mem-$avail_mem)*100/$total_mem" | bc)

echo "Total Memory     : $total_mem MB"
echo "Available Memory : $avail_mem MB"
echo "Memory Usage     : $used_mem %"

echo "======================================================"
echo

# Threshold logic
if (( $(echo "$used_mem > 90" | bc -l) ))
then
    echo "STATUS : CRITICAL"
    echo
    echo "Top memory consuming processes:"
    echo
    ps aux --sort=-%mem | head -6
    echo

elif (( $(echo "$used_mem > 80" | bc -l) ))
then
    echo "STATUS : HIGH"
    echo
    echo "Top memory consuming processes:"
    echo
    ps aux --sort=-%mem | head -6
    echo

elif (( $(echo "$used_mem > 65" | bc -l) ))
then
    echo "STATUS : WARNING"
    echo

else
    echo "STATUS : OK"
    echo
fi
