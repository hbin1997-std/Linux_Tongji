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

# bbins   - number of Back Azimuth bins (integer)
# fbins   - number of frequency bins (integer)
# fmin    - minimum frequency to be plotted
# fmax    - maximum frequency to be plotted
# dopcut  - lower cut off of DoP 
#           DoP >= dopcut will be plotted
# stnm    - station name folder in Results/ holding
#           year-long measurements. This will also be
#           the station name label in the figure
#           e.g. Results/ABCD where ABCD folder holds
#                measurements.
# month   - 0 = full duration of measurements 
#           1 = custom duration of measurements
#           2 = hard coded path for this example
#           if =1, then copy corresponding data files
#           to a sub-directory named 000_month/.
#           e.g. Results/ABCD/000_month
#           if =2, then use ../2010-E085c/Results 
#           (added to work with the provided example)
# mmyy    - The data duration label in the figure.
#           Keep it short and consistent.
#           e.g. 2017-2018 or Jan-2018

bbins='30'
fbins='20'
fmin='0.05'
fmax='0.3'
dopcut='0.7'
#stnm='M.KMD13'
month='9'
#mmyy='SEP-2017'


read -p "Enter the date > " mmyy
echo ${mmyy}

read -p "Enter the folder > " stnm
echo ${stnm}


#################### START 2-D BINNING ####################

bazmin='-180'
bazmax='180'

if [ "$month" -eq 0 ]
then
data_dir="../Results/${stnm}"
elif [ "$month" -eq 1 ]
then
data_dir="../Results/${stnm}/000_month"
elif [ "$month" -eq 2 ]
then
data_dir="../2010-E085c/Results_bak"
fi
data_dir="/home/binh/yingpan/sac_processed/Data/${mmyy}_m/Results_"${stnm}
echo $data_dir



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

awk -v dop=$dopcut '($1 < 1000 && $3 >= dop) {print $1,$2}' ${data_dir}/*.dat > tmp1.txt

awk -v xmin=$bazmin -v xmax=$bazmax -v xn=$bbins -v ymin=$fmin   -v ymax=$fmax   -v yn=$fbins '
    
    ($1 >= xmin && $1 < xmax && $2 >= ymin && $2 < ymax) {
     xi = int(xn * ($1 - xmin) / (xmax - xmin)) ; if (xi >= xn) xi = xn - 1
     yi = int(yn * ($2 - ymin) / (ymax - ymin)) ; if (yi >= yn) yi = yn - 1
     h[yi,xi]++
     n++
    }

     END {
            xscale = (xmax - xmin) / xn
            yscale = (ymax - ymin) / yn
                if (n > 0)
                    percent = 100.0 / n
                else
                    percent = 0.0
                for (yi = 0; yi < yn; yi++)
                    for (xi = 0; xi < xn; xi++)
                        printf("%7.2f  %8.4f  %8.4f\n",
                                xmin + xscale * (xi + 0.5),
                                ymin + yscale * (yi + 0.5),
                                h[yi,xi]) 
         } ' tmp1.txt > tmp2.txt




############################# GMT ############################
# GMT PLOTTING
proj='Pa5i'
proj2='X5i/5i'
range="${bazmin}/${bazmax}/${fmin}/${fmax}"
range2='0/10/0/10'
baz_grid='20'
cmap='seis'
outps="${stnm}_${mmyy}_DoP.ps"

gmt info -C tmp2.txt > tmp3.txt
tmax=`awk '{ print $6}' tmp3.txt`
binc=$(echo "scale=2; ( $bazmax - $bazmin ) / $bbins" | bc)
finc=$(echo "scale=4; ( $fmax - $fmin ) / $fbins" | bc)
labtinc=$(echo "scale=4; 1 / 5" | bc)
labl='Normalized DoP Signal Counts'
echo "\n INTERVALS: BAZ=$binc dF=$finc\n"

# normalize DoP by the max value: $tmax
awk -v nm=$tmax '{ print $1,$2,$3/nm }' tmp2.txt > tmp4.txt

# make the color palette
gmt makecpt -C$cmap -T0/1/0.1 -D -I -N -V -Z > dop.cpt

# grid operations
gmt gmtset MAP_GRID_PEN_PRIMARY 0.4p,white
gmt blockmean tmp4.txt -R$range -I${binc}/${finc} -fi0x,1f,2f -C -V > block.xyz
gmt surface block.xyz -R$range -I${binc}/${finc} -V -T0.25 -Gdop.grd

# plotting
gmt psxy -J$proj -R$range -T -K -V -P > $outps
gmt grdimage dop.grd -J$proj -R$range -Cdop.cpt \
    -Bxa${baz_grid}g${baz_grid} -Byag -BsWNe -n+c -V -K -O -P >> $outps
gmt psscale -J$proj -R$range -Dx5.7i/2.5i/3i/0.1i \
    -Bx"${labtinc}"+l"$labl" \
    -Cdop.cpt -O -V -P -K >> $outps
gmt pstext -J$proj2 -R$range2 -X2i -F+f16p,4+jLB -O -V -P >> $outps << END
6.0 1.0 $fmin - $fmax Hz
6.0 0.5 DoP >= $dopcut
7.0 9.0 $stnm
6.7 8.5 $mmyy
END

gmt psconvert -A -E300i $outps -Tj

rm tmp?.txt *.cpt *.grd block.xyz gmt.history gmt.conf
