#!/bin/sh

cd /home/binh/Donet/D_obs/esac
for file in `ls`
do
for ((i=1;i<=30;i++))
do
echo ${i}
echo ${file%_*}
if [[ ${file%_*} == 202011-${i} ]]; then

echo "1"
mv /home/binh/Donet/D_obs/esac/${file} /home/binh/Donet/D_obs/D_obs_d/202011-${i}
fi

#mv ${file%_*}*  /home/binh/Donet/D_obs_d/${file%.*}
done
done
