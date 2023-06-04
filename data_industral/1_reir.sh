#!/bin/bash
# BY BINH 2020/11/19
echo "remove the IR of Donet DATA"
read -p "Enter the folder > " dat
echo ${dat}

cd /home/binh/yingpan/data_industral/${dat}

path=`pwd`

echo ${path}

for date in `ls`
do
echo ${date}
cd ${path}/${date}

for sta in `ls`
do
echo ${sta} 

cd ${path}/${date}/${sta}
{
sac << EOF

r *.X.sac
rmean
rtr
trans from evalresp STATION ${sta:2:5} NETWORK * CHANNEL BHX fname /home/binh/Donet/DONET_RESP/${sta}/RESP.*.${sta}.BHX to vel freq 0.001 0.005 5 10
w over
q
EOF
echo 'BHX FI' 


sac << EOF

r *.Y.sac
rmean
rtr
trans from evalresp STATION ${sta:2:5} NETWORK * CHANNEL BHY fname /home/binh/Donet/DONET_RESP/${sta}/RESP.*.${sta}.BHY to vel freq 0.001 0.005 5 10
w over
q
EOF
echo 'BHY FI' 

sac << EOF
r *.Z.sac
rmean
rtr
trans from evalresp STATION ${sta:2:5} NETWORK * CHANNEL BHZ fname /home/binh/Donet/DONET_RESP/${sta}/RESP.*.${sta}.BHZ to vel freq 0.001 0.005 5 10
w over
q
EOF
echo 'BHZ FI' 

}&
done
wait

done





