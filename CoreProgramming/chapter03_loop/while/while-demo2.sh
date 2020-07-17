#!/bin/bash
# 功能描述：while 循环语句基本语法演示
# 输出 5 次hello world，并输出变量i的值

i=1
while [ $i -le 5 ]
do 
    echo "hello world"
    echo "$i"
    let i++
done