#!/usr/bin/env bash

m=`<big.txt`

len=`head -n 1 <<< "$m" | wc -c`

cnt()(a=`rg --count-matches XMAS <<< "$1"`;echo ${a:-'0'})
transpose()(seq 1 $len | xargs -I {} sh -c "echo \"$1\" | sd '(.)' '\\\$1 ' | cut -d' ' -f {} | xargs echo")

for _ in `seq 0 3`; do
    diag_m=`sd '(.)' '\$1 ' <<< $m | awk '{ print $0, "|"}'`
    for i in `seq 1 $len`; do 
        t=$[t + `cnt $(awk '{ print $NR }' <<< $diag_m | tr -d '\n')`]
        diag_m=`awk '{ l=$NF; $NF=""; print l,$0 }' <<< $diag_m`
    done

    t=$[t + `cnt "$m"`]

    m=`transpose "$(tac <<< "$m")" | tr -d ' '`
done

echo "$t"
