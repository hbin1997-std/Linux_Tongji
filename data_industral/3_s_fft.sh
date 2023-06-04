#!/bin/sh
# By Binh 2020.10.16
echo "fft transformation of each hour"
<<!
read -p "Enter the folder > " dat
echo ${dat}
!
cha=BHZ

cd /home/binh/yingpan/sac_processed/NZ_ori_data/Nz_2_data/
path=`pwd`
echo ${path}

for date in `ls`
do
cd ${path}/${date}


for sta in  `ls`
do
cd ${path}/${date}/${sta}/${cha}

for day in `ls`
do

cd ${path}/${date}/${sta}/${cha}/${day}

pwd

mkdir -p  /home/binh/yingpan/data_instrual/am_file/${date}/${day}/${sta}/${cha}.am
# FFT
for file in *.sac
do
sac <<EOF

    r ${file}
    fft 
    writesp am ${file%.sac*}
    
exit
EOF
mv *.am  /home/binh/yingpan/data_instrual/am_file/${date}/${day}/${sta}/${cha}.am

done
done
done
done
