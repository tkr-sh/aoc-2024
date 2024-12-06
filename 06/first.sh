#!/usr/bin/env bash 

IFS=':' read y x line <<< `rg --column -n '\^' < big.txt`
width=`wc -m <<< $line `
m=`<big.txt`

while [ $x -gt 0 ] && [ $x -le $width ] && [ $y -gt 0 ] && [ $y -le $width ]; do
    if [[ `sed -n "${y}p" <<< "$m" | cut -c $x` == '#' ]]; then
        if [ $[rot % 2] = 1 ]; then
            x=$[x + rot - 2]
        else 
            y=$[y - rot + 1]
        fi
        rot=$[(rot + 1)%4]
    else
        m=`sed "${y}s/./X/${x}" <<< "$m"`
    fi

    if [ $[rot % 2] = 1 ]; then
        x=$[x - rot + 2]
    else 
        y=$[y + rot - 1]
    fi
done


rg -o 'X' <<< "$m" | wc -l
