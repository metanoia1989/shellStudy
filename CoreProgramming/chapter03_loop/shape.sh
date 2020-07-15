#!/bin/bash
# 功能描述：打印各种色块形状

for i in $(seq 6)
do
    for j in $(seq $i)
    do
        echo -ne "\e[101m  \e[0m"
    done
    echo 
done


echo -e "\n使用C语言风格的for循环语句："
for ((i=1; i<=6; i++))
do
    for ((j=6; j>=i; j--))
    do
        echo -ne "\e[46m  \e[0m"
    done
    echo
done

echo -e "\n一二的组合："
for ((i=1; i<=5; i++))
do
    for ((j=1; j<=i; j++))
    do
        echo -ne "\e[46m  \e[0m"
    done
    echo
done
for ((i=4; i>=1; i--))
do
    for ((j=i; j>=1; j--))
    do
        echo -ne "\e[46m  \e[0m"
    done
    echo
done