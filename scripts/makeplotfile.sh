#! /bin/bash
#
#author: Michael Bengfort (michael.bengfort@hzg.de)
# run with "./makeplotfile.sh 'testscript.pdf' 'output.dat' 13 'low' 'x11'"
plotfile='plotfile.plt'
Obsfolder='../Observations'
outputfile=${1}
inputfile=${2}
phyto_num=${3}
loworhigh=${4}
terminal=${5}
#########################
rm ${plotfile}
echo 'reset' >> ${plotfile}
echo 'unset multiplot' >> ${plotfile}
if [ ${terminal} = 'x11' ]; then
  echo "set terminal x11 enhanced" >> ${plotfile}
else
  echo 'set terminal pdf enhanced color fontscale 0.2' >> ${plotfile}
  echo "set output '$outputfile'" >> ${plotfile}
fi
echo 'set multiplot layout 5,4' >> ${plotfile}
# echo 'set xdata time' >> ${plotfile}
# echo 'set timefmt "%Y-%m-%d %H:%M:%S"' >> ${plotfile}
# echo 'set format x "%m-%d"' >> ${plotfile}
echo 'set ytics nomirror' >> ${plotfile}
#Define Linecolors
echo "set style line 2  lc rgb '#0025ad' lt 1 lw 1.5 # --- blue" >>${plotfile}
echo "set style line 3  lc rgb '#0042ad' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 4  lc rgb '#0060ad' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 5  lc rgb '#007cad' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 6  lc rgb '#0099ad' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 7  lc rgb '#00ada4' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 8  lc rgb '#00ad88' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 9  lc rgb '#00ad6b' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 10 lc rgb '#00ad4e' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 11 lc rgb '#00ad31' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 12 lc rgb '#00ad14' lt 1 lw 1.5 #      ." >>${plotfile}
echo "set style line 13 lc rgb '#09ad00' lt 1 lw 1.5 # --- green" >>${plotfile}
echo "set style line 14 lc rgb '#08ad00' lt 1 lw 1.5 # ---?" >>${plotfile}
######
echo "unset key" >> ${plotfile}
echo "set ylabel 'biomass ({/Symbol m}mol-C L^{-1})'" >> ${plotfile}
echo "set xlabel 'time (d)'" >> ${plotfile}
let lines=2
printf  "plot '${inputfile}' u (\$0*2):3 w l ls ${lines} t 'Phy_1'" >> ${plotfile}
for (( k = 1 ; k < ${3} ; k++))
	do
	  let row=3+$k*3
	  let species=1+$k
	  let lines=${lines}+1
	  printf ",'${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'Phy_${species}'" >> ${plotfile}
done
printf "\n" >> ${plotfile}
######
echo "set key bottom left" >> ${plotfile}
echo "set ylabel 'Q_N'" >> ${plotfile}
echo "set xlabel 'time (d)'" >> ${plotfile}
let lines=2
# printf  "plot '${inputfile}' u (\$0*2):4 w l ls ${lines} t 'Phy_1'" >> ${plotfile}
# for (( k = 1 ; k < ${3} ; k++))
# 	do
# 	  let row=4+$k*3
# 	  let species=1+$k
# 	  let lines=${lines}+1
# 	  printf ",'${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'Phy_${species}'" >> ${plotfile}
# done
let row=4+3
printf  "plot '${inputfile}' u (\$0*2):${row} w l t 'small'" >> ${plotfile}
let dist=${phyto_num}/2-1
let row=$row+3*$dist
printf ",'${inputfile}' u (\$0*2):$row w l t 'medium'" >> ${plotfile}
let row=$row+3*$dist
printf ",'${inputfile}' u (\$0*2):${row} w l t 'large'" >> ${plotfile}
let row=${row}+4
printf "\n" >> ${plotfile}
######
echo "set ylabel 'Q_P'" >> ${plotfile}
echo "set xlabel 'time (d)'" >> ${plotfile}
let lines=2
# printf  "plot '${inputfile}' u (\$0*2):5 w l ls ${lines} t 'Phy_1'" >> ${plotfile}
# for (( k = 1 ; k < ${3} ; k++))
# 	do
# 	  let row=5+$k*3
# 	  let species=1+$k
# 	  let lines=${lines}+1
# 	  printf ",'${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'Phy_${species}'" >> ${plotfile}
# done
let row=5+3
printf  "plot '${inputfile}' u (\$0*2):${row} w l t 'small'" >> ${plotfile}
let row=$row+3*$dist
printf ",'${inputfile}' u (\$0*2):$row w l t 'medium'" >> ${plotfile}
let row=$row+3*$dist
printf ",'${inputfile}' u (\$0*2):${row} w l t 'large'" >> ${plotfile}
let row=${row}+4
printf "\n" >> ${plotfile}
echo "set key" >> ${plotfile}
# ##################################
echo 'set y2tics' >> ${plotfile}
echo "set key top right" >> ${plotfile}
echo "set ylabel 'N ({/Symbol m}mol-C L^{-1})'" >> ${plotfile}
echo "set y2label 'P ({/Symbol m}mol-C L^{-1})'" >> ${plotfile}
printf "plot '${inputfile}' u (\$0*2):${row} w l t 'N' lc rgb 'red'" >> ${plotfile}
let row=${row}+1
printf ",'${inputfile}'  u (\$0*2):${row} axes x1y2 w l  t 'P' lc rgb 'green','${Obsfolder}/${loworhigh}CO2.dat' u (\$0*2):3 axes x1y1 w p pt 6 ps 0.5 lc rgb 'red' notitle,'${Obsfolder}/${loworhigh}CO2.dat' u (\$0*2):4 axes x1y2 w p pt 6 ps 0.5 lc rgb 'green' notitle\n" >> ${plotfile}
printf '\n' >> ${plotfile}
echo "set ylabel 'D_N ({/Symbol m}mol-C L^{-1})'" >> ${plotfile}
echo "set y2label 'D_P ({/Symbol m}mol-C L^{-1})'" >> ${plotfile}
let row=${row}+1
printf "plot '${inputfile}' u (\$0*2):${row} w l t 'D_N'" >> ${plotfile}
let row=${row}+1
printf ", '${inputfile}' u (\$0*2):${row} axes x1y2 w l  t 'D_P'\n" >> ${plotfile}
###
let row=${row}+1
echo "unset key" >> ${plotfile}
echo "unset y2tics" >> ${plotfile}
echo "unset y2label" >> ${plotfile}
echo "set ylabel 'Chl_a {/Symbol m}gL^{-1}'" >> ${plotfile}
echo "plot '${inputfile}' u (\$0*2):${row} w l t 'Chl_a', '${Obsfolder}/${loworhigh}CO2.dat' u (\$0*2):7 w p pt 6 ps 0.5 lc rgb 'black' notitle" >>${plotfile}
##
###
 let row=${row}+2
# echo "unset y2tics" >> ${plotfile}
# echo "unset y2label" >> ${plotfile}
# echo "set ylabel 'POC {/Symbol m}mol-C L^{-1}'" >> ${plotfile}
# echo "plot '${inputfile}' u (\$0*2):${row} w l t 'POC', '${Obsfolder}/${loworhigh}CO2.dat' u (\$0*2):5 w p pt 6 ps 0.5 lc rgb 'black' notitle" >>${plotfile}
# ##
# let row=${row}+1
# echo "unset y2tics" >> ${plotfile}
# echo "unset y2label" >> ${plotfile}
# echo "set ylabel 'PON'" >> ${plotfile}
# echo "plot '${inputfile}' u (\$0*2):${row} w l t 'PON', '${Obsfolder}/${loworhigh}CO2.dat' u (\$0*2):6 w p pt 6 ps 0.5 lc rgb 'black' notitle" >>${plotfile}
# ##

##
echo "set key" >> ${plotfile}
echo "set y2tics" >> ${plotfile}
echo "set ylabel '{/Symbol m}m'" >>${plotfile}
let row=${row}+1
printf "plot '${inputfile}' u (\$0*2):${row} axes x1y1 w l lc rgb 'red' t 'Mean cell size','${Obsfolder}/${loworhigh}CO2.dat' u (\$0*2):8 axes x1y1 w p pt 6 ps 0.5 lc rgb 'red' notitle" >> ${plotfile}
let row=${row}+1
printf ",'${inputfile}' u (\$0*2):${row} axes x1y2 w l t 'size diverstiy'\n" >> ${plotfile}
#
####Focing
echo "unset key" >> ${plotfile}
echo "unset y2tics" >> ${plotfile}
#echo 'set xrange ["2013-03-10":"2013-03-17"]' >> ${plotfile}
echo "set ylabel 'PAR-Forcing'" >> ${plotfile}
let row=${row}+1
let species=1
let lines=2
printf "plot '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'Phy_${species}'" >> ${plotfile}
for (( k=1 ; k < ${3} ; k++))
      do
         let row=${row}+1
         let species=${species}+1
         let lines=${lines}+1
         printf ", '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'Phy_${species}'" >> ${plotfile}
done
printf '\n'>> ${plotfile}
echo "set autoscale x" >> ${plotfile}
echo "set ylabel 'CO2-Forcing'" >> ${plotfile}
let row=${row}+1
let species=1
let lines=2
printf "plot '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'Phy_${species}'">> ${plotfile}
for (( k=1 ; k < ${3} ; k++))
      do
         let row=${row}+1
         let species=${species}+1
	 let lines=${lines}+1
	 printf ", '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'Phy_${species}'" >> ${plotfile}
done
printf '\n' >> ${plotfile}
echo "set ylabel 'grazing-Forcing'" >> ${plotfile}
echo "set key top left" >> ${plotfile}
#echo "set logscale y" >> ${plotfile}
let row=${row}+1
let species=1
let lines=2
#echo "unset key" >> ${plotfile}
#printf "plot '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'Phy_${species}'">> ${plotfile}
# for (( k=1 ; k < ${3} ; k++))
#       do
#          let row=${row}+1
#          let species=${species}+1
#          let lines=${lines}+1
# printf ", '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'Phy_${species}'" >> ${plotfile}
# done
let row=${row}+1
printf  "plot '${inputfile}' u (\$0*2):${row} w l t 'small'" >> ${plotfile}
let row=$row+$dist
printf ",'${inputfile}' u (\$0*2):$row w l t 'medium'" >> ${plotfile}
let row=$row+$dist
printf ",'${inputfile}' u (\$0*2):${row} w l t 'large'" >> ${plotfile}
let row=${row}+1
printf '\n' >> ${plotfile}
echo "set key" >> ${plotfile}
echo "unset logscale y" >> ${plotfile}
printf "\n" >>${plotfile}
##
echo "set key left" >> ${plotfile}
echo "set ylabel 'Temperature forcing'" >> ${plotfile}
let row=${row}+1
printf "plot '${inputfile}' u (\$0*2):${row} w l t 'TF_{Phy}'" >> ${plotfile}
let row=${row}+1
printf ", '${inputfile}' u (\$0*2):${row} w l t 'TF_{Zoo}'\n" >> ${plotfile}
#Uptake####
#echo "set logscale y" >> ${plotfile}
echo "unset key" >>${plotfile}
echo "set ylabel 'uptake N'" >> ${plotfile}
let row=${row}+1
let species=1
let lines=2
# printf "plot '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'uptake_N_${species}'" >> ${plotfile}
# for (( k=1 ; k < ${3} ; k++))
#       do
#        let row=${row}+1
#        let species=${species}+1
#        let lines=${lines}+1
#        printf ", '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'uptake_N_${species}'" >> ${plotfile}
# done
# printf '\n' >> ${plotfile}
let row=${row}+1
printf  "plot '${inputfile}' u (\$0*2):${row} w l t 'small'" >> ${plotfile}
let row=$row+$dist
printf ",'${inputfile}' u (\$0*2):$row w l t 'medium'" >> ${plotfile}
let row=$row+$dist
printf ",'${inputfile}' u (\$0*2):${row} w l t 'large'" >> ${plotfile}
let row=${row}+1
printf '\n' >> ${plotfile}
##
echo "set ylabel 'uptake P'" >> ${plotfile}
let row=${row}+1
let species=1
let lines=2
# printf "plot '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'uptake_P_${species}'" >> ${plotfile}
# for (( k=1 ; k < ${3} ; k++))
#       do
#        let row=${row}+1
#        let species=${species}+1
#        let lines=${lines}+1
#        printf ", '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'uptake_P_${species}'" >> ${plotfile}
# done
# printf '\n' >> ${plotfile}
##
let row=${row}+1
printf  "plot '${inputfile}' u (\$0*2):${row} w l t 'small'" >> ${plotfile}
let row=$row+$dist
printf ",'${inputfile}' u (\$0*2):$row w l t 'medium'" >> ${plotfile}
let row=$row+$dist
printf ",'${inputfile}' u (\$0*2):${row} w l t 'large'" >> ${plotfile}
let row=${row}+1
printf '\n' >> ${plotfile}
echo "set ylabel 'max. ingestion'" >> ${plotfile}
echo "unset logscale y" >> ${plotfile}
echo "set key" >> ${plotfile}
let row=${row}+1
let species=1
printf "plot '${inputfile}' u (\$0*2):${row} w l t 'I^1_{max}'" >> ${plotfile}
for (( k=1 ; k < 3 ; k++))
      do
       let row=${row}+1
       let species=${species}+1
       let lines=${lines}+1
       printf ", '${inputfile}' u (\$0*2):${row} w l t 'I^${species}_{max}'" >> ${plotfile}
done
printf '\n' >> ${plotfile}
echo "set key right" >> ${plotfile}
echo "set ylabel 'growth'" >> ${plotfile}
let row=${row}+2
printf "plot '${inputfile}' u (\$0*2):${row} w l t 'small'" >> ${plotfile}
let row=$row+$dist
printf ", '${inputfile}' u (\$0*2):${row} w l t 'medium'" >> ${plotfile}
let row=$row+$dist
printf ", '${inputfile}' u (\$0*2):${row} w l t 'large'\n" >> ${plotfile}
let row=$row+1
#for (( k=1 ; k < ${3} ; k++))
#      do
#       let row=${row}+1
#       let species=${species}+1
#       let lines=${lines}+1
#       printf ", '${inputfile}' u (\$0*2):${row} w l ls ${lines} t 'growth_${species}'" >> ${plotfile}
#done
###
echo "set xlabel 'time'" >> ${plotfile}
echo "set ylabel 'copepods'" >> ${plotfile}
echo "plot '$Obsfolder/copepods.dat' u (\$0*2):3 t 'high CO2','$Obsfolder/copepods.dat' u (\$0*2):4 t 'low CO2'" >> ${plotfile}
###
##
echo "set title ''">>${plotfile}
echo "set ylabel ''">>${plotfile}
let row=${row}+1
let row2=${row}+1
let row3=${row2}+1
let row4=${row3}+1
let row5=${row4}+1
echo "set autoscale y" >> ${plotfile}
printf "plot '${inputfile}' u (\$0*2):(0*\$0):${row} w filledcu title 'growth', '${inputfile}' u (\$0*2):(0*\$0) lt -1 notitle, '${inputfile}' u (\$0*2):${row} lt -1 notitle" >> ${plotfile}
printf ", '${inputfile}' u (\$0*2):(0*\$0):${row2} w filledcu title 'respiration', '${inputfile}' u (\$0*2):(0*\$0) lt -1 notitle, '${inputfile}' u (\$0*2):${row2} lt -1 notitle" >> ${plotfile}
printf ",'${inputfile}' u (\$0*2):${row2}:(\$${row2}+\$${row3}) w filledcu title 'sinking', '${inputfile}' u (\$0*2):${row2} lt -1 notitle, '${inputfile}' u (\$0*2):(\$${row2}+\$${row3}) lt -1 notitle" >> ${plotfile}
printf ",'${inputfile}' u (\$0*2):(\$${row2}+\$${row3}):(\$${row2}+\$${row3}+\$${row4}) w filledcu title 'aggregation', '${inputfile}' u (\$0*2):(\$${row2}+\$${row3}) lt -1 notitle, '${inputfile}' u (\$0*2):(\$${row2}+\$${row3}+\$${row4}) lt -1 notitle" >> ${plotfile}
printf ",'${inputfile}' u (\$0*2):(\$${row2}+\$${row3}+\$${row4}):(\$${row2}+\$${row3}+\$${row4}+\$${row5}) w filledcu title 'grazing', '${inputfile}' u (\$0*2):(\$${row2}+\$${row3}+\$${row4}) lt -1 notitle, '${inputfile}' u (\$0*2):(\$${row2}+\$${row3}+\$${row4}+\$${row5}) lt -1 notitle" >> ${plotfile}
printf "\n" >> ${plotfile}
let row=${row5}+1
##
echo "unset key" >> ${plotfile}
echo "set ylabel 'time'" >> ${plotfile}
echo "set xlabel 'size'" >> ${plotfile}
echo "set pm3d map" >> ${plotfile}
echo "set xdata" >> ${plotfile}
#echo "set format x '%1.0f'" >> ${plotfile}
echo "set ticslevel 0" >> ${plotfile}
#echo "set cbrange [0.00(\$0*2):1]" >> ${plotfile}
#echo "set logscale cb " >> ${plotfile}
echo "set yrange [0:${phyto_num}]" >> ${plotfile}
echo "set ytics ('-0.5' 0, '0.0' 1, '0.5' 2, '1.0' 3, '1.3' 4, '1.6' 5, '1.9' 6, '2.2' 7, '2.5' 8, '3.0' 9, '3.5' 10, '4.0' 11, '4.5' 12, '5.0' 13, '5.5' 14, '6.0' 15, '6.2' 16)" >> ${plotfile}
echo "set ytics offset 0,0.5" >> ${plotfile}
let endblock=${row}-1
echo "splot '${inputfile}' matrix u (\$2*2):(\$1-${endblock}):3 every ::${endblock} w pm3d" >> ${plotfile}
###


echo "unset multiplot" >> ${plotfile}
echo "set terminal x11" >> ${plotfile}