#!/bin/sh
#
# 2-D BIN
# This program builds 2-D bins from the multiday output
# of Polfre and constructs a figure with GMT. This should
# reproduce figures similar to Schimmel et al., 2011
# Fig. 10.
#
# To use month option (see USER INPUT), data must be
# stored in a sub-directory named 000_month.
#
# Januka Attanayake
# University of Melbourne
# 8 JULY 2019

######################## USER INPUT ########################

bbins='30'
fbins='20'
fmin='0.05'
fmax='0.3'
dopcut='0.7'
#stnm='M.KMD13'
month='9'
#mmyy='SEP-2017'

<<!
read -p "Enter the date > " mmyy
echo ${mmyy}
!
read -p "Enter the folder > " sta
echo ${sta}


#################### START 2-D BINNING ####################

bazmin='-180'
bazmax='180'

#sta=M.KMA03

# Make a single input file from all 
# result files in the $stnm/.
# Omit header lines.
# The first field of header is year.
# This line can be omitted by using
# a conditional statement $1 < 1000
# BAZ <= 180 and year is definitely 1000<
# A bin is centered at the midpoint of the
# range. The minimum of the range is included
# in the bin (>=) and the maximum is excluded (<).


############################# GMT ############################
# GMT PLOTTING
proj='Pa2.9c'
proj2='X5i/5i'
range="${bazmin}/${bazmax}/${fmin}/${fmax}"
range2='0/10/0/10'
baz_grid='20'
cmap='seis'


binc=$(echo "scale=2; ( $bazmax - $bazmin ) / $bbins" | bc)
finc=$(echo "scale=4; ( $fmax - $fmin ) / $fbins" | bc)
labtinc=$(echo "scale=4; 1 / 5" | bc)
labl='Normalized DoP Signal Counts'
echo "\n INTERVALS: BAZ=$binc dF=$finc\n"

gmt makecpt -C$cmap -T0/1/0.1 -D -I -N -V -Z > dop.cpt


# plotting
#gmt psxy -J$proj -R$range -T -K -V -P > ${sta}.ps
gmt grdimage ./${sta}_dop/201706_${sta}.grd -J$proj -R$range -Cdop.cpt \
    -Bxa${baz_grid}g${baz_grid} -Byag -Bswne -n+c -V -K -X1.5c -Y24c -P > ${sta}.ps

txt1=201706
echo 0.15 0.34 $txt1 | gmt pstext  -K -O -V -R0/1/0/1 -JX10/10  -F+f14p,4+jMC >> ${sta}.ps
echo 9.15 0.28 "(a)" ${sta} | gmt pstext  -O -K -V -R0/15/0/1 -JX15c  -F+f18p,4+jMC >>  ${sta}.ps



for dat in 201707 201708 201709 201710 201711 
do
echo ${dat}
gmt grdimage ./${sta}_dop/${dat}_${sta}.grd -J$proj -R$range -Cdop.cpt \
    -Bxa${baz_grid}g${baz_grid} -Byag -Bswne -n+c -V -O -K -X3.1c -Y0c -P >> ${sta}.ps
txt3=${dat}
echo 0.15 0.34 $txt3 | gmt pstext -K -O -V -R0/1/0/1 -JX10/10  -F+f14p,4+jMC >> ${sta}.ps
done

gmt grdimage ./${sta}_dop/201712_${sta}.grd -J$proj -R$range -Cdop.cpt \
    -Bxa${baz_grid}g${baz_grid} -Byag -Bswne -n+c -V -K -O -X-15.5c -Y-4.2c -P >> ${sta}.ps

txt1=201712
echo 0.15 0.34 $txt1 | gmt pstext -K -O -V -R0/1/0/1 -JX10/10  -F+f14p,4+jMC >> ${sta}.ps


for dat in  201801 201802 201803 201804 201805 
do
echo ${dat}
gmt grdimage ./${sta}_dop/${dat}_${sta}.grd -J$proj -R$range -Cdop.cpt \
    -Bxa${baz_grid}g${baz_grid} -Byag -Bswne -n+c -V -O -K -X3.1c -Y0c -P >> ${sta}.ps
txt3=${dat}
echo 0.15 0.34 $txt3 | gmt pstext -K -O -V -R0/1/0/1 -JX10/10  -F+f14p,4+jMC >>${sta}.ps
done









gmt psscale -J$proj -R$range -Dx5.7i/2.5i/3i/0.1i \
    -Bx"${labtinc}"+l"$labl" \
    -Cdop.cpt -O -V -P -K >> ${sta}.ps







<<!

gmt pstext -J$proj2 -R$range2 -X2i -F+f16p,4+jLB -O -V -P >> ${sta}.ps << END
6.0 1.0 $fmin - $fmax Hz
6.0 0.5 DoP >= $dopcut
7.0 9.0 $sta
6.7 8.5 $month
END
!



#gmt psconvert -A -E300i $outps -Tj

#rm tmp?.txt *.cpt *.grd block.xyz gmt.history gmt.conf
