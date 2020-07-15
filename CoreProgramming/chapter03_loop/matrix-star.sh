#!/bin/bash
# 循环嵌套语句：一个循环体内再嵌套另外一个循环体

for i in {1..5}
do 
    for j in {1..5}
    do 
        echo -n "* "
    done
    echo 
done