#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "用法: $0 <文件名>"
    exit 1
fi

filename="$1"
total_sum=0

while IFS= read -r line; do
    # 将每行的字符串转换为浮点数，并进行累加
    number=$(echo "$line" | awk '{printf "%.10g", $0}')
    if [[ $number =~ ^-?[0-9]*(\.[0-9]+)?$ ]]; then
        total_sum=$(echo "$total_sum + $number" | bc)
    else
        echo "无法转换为数字: $line"
    fi
done < "$filename"

echo "总和: $total_sum"