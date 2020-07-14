#!/bin/bash

# Shell脚本通过循环解决重复任务。包括 for、while、untile、select
<<'EOF'
for 循环基本语法格式：
for name [ in [ word ... ]]
do
    命令序列
done

name 为任意定义的变量名称
word 是支持扩展的项目列表
name 会逐一提取项目列表中的每一个值，每提取一个值就会执行一次do和done中间的命令序列。   
EOF

for i in 1 2 3 4 5
do 
    echo "hello word $i"
done


<<'EOF'
变量name不定义取值范围的for循环：
for name
do
    命令序列
done

如果变量 name 没有定义取值范围，则默认取值为 $@，也就是所有位置变量的值。
有几个位置变量，该for循环就循环几次。   
EOF

for i
do
    echo "位置变量：$i"
done


<<'EOF'
C语言风格for循环语法格式：
for (( expr1 ; expr2 ; expr3 ))
do 
    命令序列
done

该语法格式中expr1、expr2和expr3代表的都是算术表达式，
其中expr1的作用是进行初始化赋值。
expr2是判断循环是否继续的条件，如果expr2的条件判断为非0。
则do和done中间的命令序列就会执行一次，并且触发执行一次expr3。
依此类推，直到expr2的判断条件为0时，整个循环结束。
EOF