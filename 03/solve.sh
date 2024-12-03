input=$(cat input)
commands=$(echo $input | grep -o -E "mul\([0-9]+,[0-9]+\)" | sed -e 's/mul(//g' -e 's/)//g' -e 's/,/*/g')
addition=$(echo "$commands" | bc | sed 's/$/\ +/g'| tr '\n' ' ')
# sed to remove last +
echo $addition | rev | cut -c2- | rev | bc


