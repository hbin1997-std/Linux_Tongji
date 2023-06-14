#!/bin/sh
# By Binh 2020.10.12
echo "批量解压Donet数据"

set -e

cd /home/binh/Donet/process/201711

path=`pwd`
echo $path; #show the current path

for j in `ls`
do
echo "${j}"
cd /${path}/${j}

for i in `ls`
do

#echo "${i}"
 
 filename=${i%.zip*}  #remove the file type

  mkdir -p /home/binh/Donet/jy/$j/${filename}

  unzip  $i -d /home/binh/Donet/jy/$j/${filename}

 #tar -zxvf $i -d /home/binh/Donet/jy/$j/${filename}

done


done


