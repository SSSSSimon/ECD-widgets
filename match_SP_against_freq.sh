#!/bin/bash
  
freq=($(ls opt_freq/))
sp=($(ls SP/))

# $1=freq $2=sp
for ((i=0;i<${#sp[@]};i++))
do
    for ((j=0;j<${#freq[@]};j++))
    do
    #echo "running ${freq[$j]} ${sp[$i]}"
    "./find_cords_from_orca"  opt_freq/${freq[$j]} SP/${sp[$i]}
    if [ $? -eq 1 ]
    then
        echo "${sp[$i]} is ${freq[$j]}"
    fi
    done
done
