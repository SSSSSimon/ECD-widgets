#!/bin/bash

freq=($(ls opt_freq/*.out))

for ((i=0;i<${#freq[@]};i++))
do
echo "80"
echo -en "G = "
cat "${freq}" |grep "Final Gibbs free energy" | awk 'BEGIN{ORS=""}{print $6}'
echo -en "    Gcorr = "
cat "${freq}" |grep "G-E(el)" | awk '{print $3}'
"./get_geom_from_freq" ${freq}
done