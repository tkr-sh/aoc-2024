#!/usr/bin/env bash

while read line; do
    IFS=":" read look_for numbers <<< "$line"

    echo "$numbers"
    rg -o <<< "$numbers" | wc -l
    spaces=$[`rg -o ' ' <<< "$numbers" | wc -l` - 1]
    go_to=`bc <<< "2^$spaces"`

    from=0

    while [[ $go_to -gt $from ]]; do
        operators=`printf "%0$[spaces]d" $(dc -e "$from 2op") | tr '01' '+*'`
        expr_in_lines=`paste -d'\n' <(echo -e "$(tr ' ' '\n' <<< $numbers | tail -n +2)") <(echo -e "$(sd '(.)' ')$1\n' <<< $operators)")`
        number=`bc <<< "$(printf "%${spaces}s" | tr ' ' '(')$(tr -d '\n' <<< "$expr_in_lines")"`

        if [[ $number = "$look_for" ]]; then
            echo "[$tot $look_for]"
            tot=$[tot+look_for]
            break
        fi
        from=$[from + 1]
    done
done < big.txt

echo "Total: $tot"
