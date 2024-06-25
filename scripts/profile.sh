#!/bin/zsh

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <parameter> <iterations> <output_file>"
    exit 1
fi

parameter=$1
iterations=$2
output_file=$3

for i in $(seq 1 "$iterations"); do
    sf apex run --file "$parameter" | sed -rn 's/.*USER_DEBUG\|\[[0-9]+\]\|DEBUG\|(.*)/\1/p' >> "$output_file" 
done