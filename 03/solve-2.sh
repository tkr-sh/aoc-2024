input=$(cat input)
commands=$(echo $input | grep -o -E -e "mul\([0-9]+,[0-9]+\)" -e "do" -e "don't" | sed -e 's/mul(//g' -e 's/)//g' -e 's/,/*/g' | tr '\n' ' ' | sed 's/do/\ndo/g' | grep -v "^don't " | sed 's/do//g')
addition=$(echo $commands | sed 's/\ /+/g')

echo "$addition" | bc



