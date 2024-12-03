#!/usr/bin/env bash

mul(){ echo $[$1 * $2]
}

eval "echo \$[\`$(rg -N -o "mul\(\d+,\d+\)" big.txt | tr ',()' ' ' | sd '\n' '`+`' | head -c -2)]"
