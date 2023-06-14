#!/bin/bash
#By Binh 2020.10.13


cd /home/binh/Donet/20170601

pwd
 
for j in `ls`
do
echo $j
 

mkdir -p /home/binh/Donet/20170904/${j:0:7}

 
mv ${j} /home/binh/Donet/20170904/${j:0:7}


done
