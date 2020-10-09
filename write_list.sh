#!/bin/bash

freq=($(ls freq/*.out))
sp=($(ls SP/))

for ((i=0;i<${#freq[@]};i++))
do
echo -en "${PWD}/${freq[$i]};"
cat "SP/${sp[$i]}/${sp[$i]}.out" |grep "FINAL" | awk '{print $5}'
done
