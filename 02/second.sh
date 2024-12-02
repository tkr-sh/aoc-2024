while read p; do
    echo "==$p=="
    echo "d = $d"


    a=($p)

    for j in -1 "${!a[@]}"; do
        is_valid=1

        if [ $j = 0 ]; then
            first=2
            second=3
        elif [ $j = 1 ]; then
            first=1
            second=3
        else
            first=1
            second=2
        fi

        s="{print (\$$second - \$$first > 0 ? 1 : 0)}"

        initial_diff=`awk "$s" <<< "$p"`

        echo "{print (\$$second - \$$first > 0 ? 1 : 0)}"
        echo $initial_diff

        for i in  "${!a[@]}"; do
            [ $i = $j ] && continue

            if [ $[$i + 1] = $j ]; then 
                next_i=$[ i + 2 ]
            else
                next_i=$[ i + 1 ]
            fi

            first=${a[$i]}
            second=${a[$next_i]}

            [ -z "$second" ] && break

            current_diff=`awk '{ print ($1 < 0 ? 1 : 0)}' <<< "$[$first - $second]"`

            if [ $initial_diff != $current_diff ] ||
                [[ $[$second - $first] -lt -3 ]] ||
                [[ $[$second - $first] -gt 3 ]] ||
                [ $second = $first ];
            then 
                is_valid=0
                break 
            fi
        done

        [ $is_valid = 1 ] && break
    done

    if [ $is_valid = 1 ]; then
        echo "$p" >> uwu.txt
        echo "$j $i | $p"
    fi

    total=$[total+is_valid]
    echo ""
done <big.txt

echo "$total"

