#!/bin/bash
# 功能描述：打印国际象棋棋盘

for i in {1..8}
do
    for j in {1..8}
    do
        sum=$[i+j]
        if [ $[sum%2] -ne 0 ]; then
            echo -ne "\e[41m   \e[0m" # 奇数深色
        else
            echo -ne "\e[47m   \e[0m" # 偶数浅色
        fi
    done
    echo 
done