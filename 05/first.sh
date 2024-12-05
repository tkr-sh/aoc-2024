#!/usr/bin/env bash

# really really slow

IFS='$' read -r corr lines <<< `sd '\n\n' '$' < big.txt | tr '\n' '%'`


corr=`tr '%' '\n' <<< "$corr"`
lines=`tr '%' '\n' <<< "$lines"`

to_map=`tr '|' '\n' <<< "$corr" | sort | uniq`

is_ok(){
    for line in $corr; do
        before_index=$(echo "$to_map" | rg -n `cut -d'|' -f1 <<< "$line"` | cut -d':' -f1)
        after_index=$(echo "$to_map" | rg -n `cut -d'|' -f2 <<< "$line"` | cut -d':' -f1)

        if [ $after_index -lt $before_index ]; then
            echo false
            return
        fi
    done

    echo true
}


for line in $lines; do
    values=`tr ',' '\n' <<< $line`

    new_corr=`rg "($(tr '\n' '|' <<< $values | head -c -1))" <<< "$corr"`

    while [ "$(is_ok)" = false ]; do
        for before_after in $new_corr; do
            before="$(cut -d'|' -f1 <<< $before_after)"
            before_index=$(echo "$to_map" | rg -n "$before" | cut -d':' -f1)
            after_index=$(echo "$to_map" | rg -n `cut -d'|' -f2 <<< "$before_after"` | cut -d':' -f1)

            if [ $after_index -lt $before_index ]; then
                to_map=`sd "$before\n" '' <<< "$to_map" | sed "1i\
$before
"`
            fi
        done
    done

    #
    ordered_lines=`rg "($(tr '\n' '|' <<< $values  | head -c -1))" <<< "$to_map"`
    a=`tr -d '\n' <<< "$values"`
    b=`tr -d '\n' <<< "$ordered_lines"`

    if [[ "$a" == "$b" ]]; then
        t=$[t + `sed -n "$[$(wc -l <<< "$ordered_lines") / 2 + 1]p" <<< "$ordered_lines"`]
    fi
done

echo "$t"
