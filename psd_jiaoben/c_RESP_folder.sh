#!/bin/bash
echo 'creat new folder for resp'


# cd /home/binh/Donet/2018_sac/20180101

cd /home/binh/C_psd/stationIR/

for i in `ls`
do
#mkdir /home/binh/C_psd/stationIR/${i}

cd /home/binh/C_psd/stationIR/${i}
rm -rf  RESP.*
for j in {BHX,BHY,BHZ}
do
#echo ${i}.${j}.pz

touch RESP.${i}.${j}

done

cd ..



done


