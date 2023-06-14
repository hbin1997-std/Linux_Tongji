#!/bin/bash
# BY BINH 2020/11/19
echo "remove the IR of Donet DATA"


cd /home/binh/Donet/sy4

for date in `ls`
do
echo ${date}
cd /home/binh/Donet/sy4/${date}

for sta in `ls`
do
echo ${sta} 

cd /home/binh/Donet/sy4/${date}/${sta}

sac << EOF

r *.X.*.sac
rmean
rtr
trans from evalresp STATION ${sta:2:5} NETWORK * CHANNEL BHX fname /home/binh/Donet/DONET_RESP/${sta}/RESP.*.${sta}.BHX to vel freq 0.001 0.005 5 10
w over
q
EOF
echo 'BHX FI' 


sac << EOF

r *.Y.*.sac
rmean
rtr
trans from evalresp STATION ${sta:2:5} NETWORK * CHANNEL BHY fname /home/binh/Donet/DONET_RESP/${sta}/RESP.*.${sta}.BHY to vel freq 0.001 0.005 5 10
w over
q
EOF
echo 'BHY FI' 

sac << EOF
r *.Z.*.sac
rmean
rtr
trans from evalresp STATION ${sta:2:5} NETWORK * CHANNEL BHZ fname /home/binh/Donet/DONET_RESP/${sta}/RESP.*.${sta}.BHZ to vel freq 0.001 0.005 5 10
w over
q
EOF
echo 'BHZ FI' 

cd ..
done

cd ..
done





