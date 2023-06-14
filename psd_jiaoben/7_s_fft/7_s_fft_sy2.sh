#!/bin/sh
echo "fft transformation of each hour"
export SAC_DISPLAY_COPYRIGHT=0

cd /home/binh/Donet/sy2


for date in `ls`
do
cd /home/binh/Donet/sy2/${date}

for sat in `ls`
do
cd /home/binh/Donet/sy2/${date}/${sat}

for cha in `ls`
do
cd /home/binh/Donet/sy2/${date}/${sat}/${cha}

mkdir -p /home/binh/Donet/am_file/${date}/${sat}/${cha}.am
# FFT
for file in *.sac
do
sac <<EOF

    r ${file}

    fft 
    writesp am ${file%.sac*}

exit
EOF
mv *.am /home/binh/Donet/am_file/${date}/${sat}/${cha}.am
done
done
done
done
