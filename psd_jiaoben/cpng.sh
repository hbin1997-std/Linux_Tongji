#!/bin/bash

cd /home/binh/Donet/picture_reir

for i in `ls`
do
echo ${i%.*}
convert ${i} ${i%.*}.png
done
