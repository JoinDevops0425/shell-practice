#!/bin/bash

a=0

while [ $a -lt 10 ]
do
    echo "Valie is $a"
done


while IFS= read -r line
do 
    echo $line
done < variables.sh