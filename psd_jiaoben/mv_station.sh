#!/bin/sh

cd /home/binh/Donet/sy
for date in `ls`
do
cd /home/binh/Donet/sy/${date}

for sat in `ls`
do
cd /home/binh/Donet/sy/${date}/${sat}


for sat2 in `ls`
do
mkdir -p /home/binh/Donet/201801_used_station/${date}

cp -r /home/binh/Donet/sy/${date}/${sat}/${sat2} /home/binh/Donet/201801_used_station/${date}

#fi
done
done
done
