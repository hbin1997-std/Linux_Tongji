#!/bin/bash
#By Binh 2020.10.13
echo "creat station folder and chose station"



cd /home/binh/Donet/24_sac/ 
path=`pwd`

for i in `ls`
do
cd /${path}/${i}
echo ${i}

for j in `ls`
do
#echo ${j}
 

mkdir -p /home/binh/Donet/24_sac/${i}/${j:0:7}

 
mv ${j} /home/binh/Donet/24_sac/${i}/${j:0:7}


done

done



