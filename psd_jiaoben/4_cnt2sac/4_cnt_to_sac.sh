#!/bin/bash
#By Binh 2020.10.15
echo "Transform the type of file"

set -e

cd /home/binh/Donet/day

#ls -A > rq.txt
#for i in $(cat rq.txt)


for i in `ls`
do
cd /home/binh/Donet/day/${i}
mkdir -p /home/binh/Donet/201709_26/${i}

win2sac_32 *.cnt /home/binh/Donet/day/4_cnt2sac/chno.file ${i}.sac /home/binh/Donet/201709_26/${i} -p/home/binh/Donet/day/4_cnt2sac/win.prm -m864000000

done






