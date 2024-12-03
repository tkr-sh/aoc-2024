#!/usr/bin/env bash

mul(){
    echo $[$1 * $2]
}

while read line; do
    for line in $(rg -o "(mul\(\d+,\d+\))|do\(\)|don't\(\)" <<< $line); do
        if [ "$line" = 'do()' ]; then
            mul(){
                echo $[$1 * $2]
            }
        elif [ "$line" = "don't()" ]; then
            mul(){
                echo 0
            }
        else
            mul=$[mul + `eval "$( tr ',()' ' ' <<< "$line")"`]
        fi
    done
done<big.txt

echo "$mul"
