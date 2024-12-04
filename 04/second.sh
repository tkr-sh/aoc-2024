#!/usr/bin/env bash

m=`<big.txt`
len=$[`head -n 1 <<< "$m" | wc -c` - 1]
match_len=$[len - 3]



transpose()(seq 1 $len | xargs -I {} sh -c "echo \"$1\" | sd '(.)' '\\\$1 ' | cut -d' ' -f {} | xargs echo")




for _ in `seq 0 3`; do

    oneline=`tr -d '\n' <<< "$m"`
    for i in `seq 0 $[(len)*(len)]`; do
        # echo "${oneline:$i:100}"
        if echo "${oneline:$i:500}" | rg "^M.S(.{$match_len}).A.(.{$match_len})M.S"; then
            echo "$t!!!"
            t=$[t+1]
        fi
    done

    echo "$m"
    m=`transpose "$(tac <<< "$m")" | tr -d ' '`
    echo "$m"
done


echo "$t"

