#!/bin/bash
# 功能描述：显示数字1和2的所有排列组合

for i in {1..2}
do
    for j in {1..2}
    do
        echo "${i}${j}"
    done
done

# 嵌套循环，内层循环和外层循环使用的变量名不能相同，否则内层变量会覆盖外层的。
echo "内外层变量相同时："
for i in {1..2}
do
    for i in {1..2}
    do
        echo "${i}${i}"
    done
done