#!/bin/zsh

if [ "$#" -ne 6 ]; then
    echo "Usage: $0 <apex_file> <start_size> <end_size> <step_size> <iterations> <output_file>"
    exit 1
fi

apex_file=$1
start_size=$2
end_size=$3
step_size=$4
iterations=$5
output_file=$6

rm -f "$output_file" || true

for ((size=start_size; size <= end_size; size += step_size)); do
  for i in $(seq 1 "$iterations"); do
      echo "Integer size=$size;" | cat - "$apex_file" | sf apex run | sed -rn 's/.*USER_DEBUG\|\[[0-9]+\]\|DEBUG\|(.*)/\1/p' >> "$output_file"         
  done
done