#!/usr/bin/env bash

mul(){
    echo $[$1 * $2]
}

while read line; do
    for line in $(rg -o "mul\(\d+,\d+\)" <<< $line); do
        mul=$[mul + `eval "$( tr ',()' ' ' <<< "$line")"`]
    done
done<big.txt

echo "$mul"
