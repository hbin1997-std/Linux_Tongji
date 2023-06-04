#!/bin/sh
# write by binh 2020/10/15
echo "split 24h to 1h"



read -p "Enter the folder > " dat
echo ${dat}


cd /home/binh/yingpan/data_industral/${dat}

path=`pwd`


for date in `ls`
do
cd ${path}/${date}

for sat in `ls`
do
{
cd ${path}/${date}/${sat}/?HZ

for file in *.sac
do

mkdir -p /home/binh/yingpan/data_industral/${dat}_am/${dat}/${file:0:8}/${sat}/HZ

echo /home/binh/yingpan/data_industral/${dat}_am/${dat}/${file:0:8}/${sat}/HZ

for ((i=0; i<=23; i++))
do

b=$[i* 3600]
e=$[b + 3600]

echo ${b} ${e}
sac <<EOF

setbb cb ${b}
setbb ce ${e}

cut %cb% %ce%

r ${file}

fft 
writesp am ${file%.sac*}-${i}
exit
EOF
  
mv   ${file%.sac*}-${i}.am /home/binh/yingpan/data_industral/${dat}_am/${dat}/${file:0:8}/${sat}/HZ

done

done
}&
done
wait
done

