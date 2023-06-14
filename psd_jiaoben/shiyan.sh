#!/bin/sh
echo "算术"

for ((i=0; i<=23; i++))
do
b=$[i* 3600]
e=$[b + 3600]

echo ${b} ${e}

done
 
