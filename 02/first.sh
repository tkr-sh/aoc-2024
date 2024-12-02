while read p; do
    initial_diff=`awk '{print ($2 - $1 > 0 ? 1 : 0)}' <<< "$p"`

    is_valid=1

    a=($p)
    for i in "${!a[@]}"; do
        first=${a[$i]}
        second=${a[$[i + 1]]}

        [ -z "$second" ] && break

        current_diff=`awk '{ print ($1 < 0 ? 1 : 0)}' <<< "$[$first - $second]"`
        
        if [ $initial_diff != $current_diff ] || [[ $[$second - $first] > 3 ]] || [ $second = $first ]; then 
            is_valid=0
            break 
        fi
    done

    total=$[total+is_valid]
done <./big.txt

echo "$total"
