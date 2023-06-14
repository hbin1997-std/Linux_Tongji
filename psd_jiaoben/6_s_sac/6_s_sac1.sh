#!/bin/sh
# write by binh 2020/10/15
echo "split 24h to 1h"

export SAC_DISPLAY_COPYRIGHT=0


cd /home/binh/Donet/sy1
for date in `ls`
do
cd /home/binh/Donet/sy1/${date}

for sat in `ls`
do
cd /home/binh/Donet/sy1/${date}/${sat}

for file in *.sac
do

mkdir -p /home/binh/Donet/1_sac/${date}/${sat}/${file:0:9}


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

write  ${file:0:9}-${i}.sac
exit
EOF
  
mv   ${file:0:9}-${i}.sac /home/binh/Donet/1_sac/${date}/${sat}/${file:0:9}
done
done
done
done
