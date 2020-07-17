#!/bin/bash

# IFS如何进行类似的特殊控制字符的设置。
# 直接设置IFS='\t'为分隔符，这样分隔符字母t
IFS="\t"
read -p "请输入3个字符【分隔符为t】：" x y z
echo $x
echo $y $z

# 设置特殊字符为分隔符 $'string' 
IFS=$'\t' # 这里的$必需的
read -p "请输入三个字符【分隔符为水平制表符】：" x y z
echo $x
echo $y
echo $z

IFS=$' \t\n' # 将IFS变量的值再次还原系统预设的默认值


