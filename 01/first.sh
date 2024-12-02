f=big.txt
a=($(awk '{print $1}' < $f | sort))
b=($(awk '{print $2}' < $f | sort))
t=0
for i in "${!a[@]}"; do d=$((b[i]-a[i])); t=$((t + ${d#-})); done
echo "$t"

