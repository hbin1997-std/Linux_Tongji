#!/bin/bash
#By Binh 2020.10.14
echo "Transform the type of file"



cd /home/binh/Donet/day_24h

#ls -A > rq.txt


for i in `ls`
do
cd /home/binh/Donet/day_24h/${i}
#mkdir -p /home/binh/Donet/jy1/${i}24h
mkdir -p /home/binh/Donet/day/${i}/

catwin32 *.cnt -o ${i}.cnt -s

mv ${i}.cnt /home/binh/Donet/day/${i}/

done



