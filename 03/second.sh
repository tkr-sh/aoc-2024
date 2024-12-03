#!/usr/bin/env bash

mul(){
    echo $[$1 * $2]
}

for match in $(rg -N -o "(mul\(\d+,\d+\))|do\(\)|don't\(\)" < big.txt); do
    if [ "$match" = 'do()' ]; then
        mul(){
            echo $[$1 * $2]
        }
    elif [ "$match" = "don't()" ]; then
        mul(){
            echo 0
        }
    else
        t=$[t + `eval "$( tr ',()' ' ' <<< "$match")"`]
    fi
done

echo "$t"
