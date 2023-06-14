#!/bin/sh

cd /home/binh/Donet/201801

for date in `ls`
do
cd /home/binh/Donet/201801/${date}

mkdir -p /home/binh/Donet/RMIR/${date}
for sat in `ls`
do
echo ${sat}
for j in $(cat /home/binh/Donet/c_station.txt) # station_used info

do
echo ${j}
if [[ ${j} == ${sat} ]]; then

cp -r /home/binh/Donet/201801/${date}/${j} /home/binh/Donet/RMIR/${date}

fi
done
done
done



