f=big.txt
a=($(awk '{print $1}' < $f | sort))
b=($(awk '{print $2}' < $f | sort))
t=0
for i in "${!a[@]}"; do t=$((t + (b[i]>a[i]?b[i]-a[i]:a[i]-b[i] ))); done
echo "$t"

