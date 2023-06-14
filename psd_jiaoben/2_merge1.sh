#!/bin/bash
# By Binh 2020.10.13
echo "Transform the type of file"

set -e

cd /home/binh/Donet/jy

#ls -A > rq.txt


for i in `ls`
do
cd /home/binh/Donet/jy/${i}

mkdir -p /home/binh/Donet/day_24h/${i}24h

#ls -A > sj.txt
for file in `ls`

do
cd /home/binh/Donet/jy/${i}/${file}

catwin32 *.cnt -o ${file}.cnt -s

mv ${file}.cnt /home/binh/Donet/day_24h/${i}24h/

done
done





