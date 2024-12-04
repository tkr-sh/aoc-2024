#!/usr/bin/env bash

m=`<big.txt`

len=`head -n 1 <<< "$m" | wc -c`

cnt()(a=`rg --count-matches XMAS <<< "$1"`;echo ${a:-'0'})
transpose()(seq 1 $len | xargs -I {} sh -c "echo \"$1\" | sd '(.)' '\\\$1 ' | cut -d' ' -f {} | xargs echo")


for _ in `seq 0 3`; do

    a=`echo "$m" | sd '(.)' '\$1 '`
    diag_m=`awk '{ print $0, "|"}' <<< $a`

    for i in `seq 1 $len`; do 
        diag=`awk '{ print $NR }' <<< $diag_m | tr -d '\n'`
        t=$[t + `cnt $diag`]
        diag_m=`awk '{ l=$NF; $NF=""; print l,$0 }' <<< $diag_m`
        echo "$diag" | rg 'XMAS' -C 10
    done


    m_cut=`tr -d ' ' <<< "$a"`
    v=`cnt "$m_cut"`
    t=$[ t + v]

    echo "=-=-=-="
    echo "$m"
    echo "---"
    echo "$m" | rg 'X M A S' -C 10
    echo "=-=-=-="

    echo "wtf $t wtf"

    m=`transpose "$(tac <<< "$m")" | tr -d ' '`
done


echo "$t"
