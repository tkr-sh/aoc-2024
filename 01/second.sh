f=big.txt
a=($(awk '{print $1}' < $f))
b=$(awk '{print $2}' < $f)

t=0
for i in "${a[@]}"; do
    count=$(rg -c $i <<< $b)
    t=$((t + count * i))
done
echo "$t"

