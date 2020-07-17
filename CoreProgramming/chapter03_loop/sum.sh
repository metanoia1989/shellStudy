#!/bin/bash
# 功能描述：计算等差数列之和 1+2+3+,...,+100

sum=0;i=1
while [ $i -le 100 ]
do
    let sum+=$i
    let i++
done
echo -e "1+2+3+,...,+100的总和为：\e[1;32m$sum\e[0m"