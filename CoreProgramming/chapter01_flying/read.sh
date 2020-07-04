#!/bin/bash

<<COMMENT
read [选项] [变量名]
如果未指定变量名，则默认变量名称为REPLY
常用命令选项如下
-p 设置提示信息
-t 设置读入数据的超时时间
-n 设置读取n个字符后结束，而默认会读取标准输入的一整行内容
-r 支持读取\，而默认read命令理解为特殊符号（转义字符）
-s 静默模式，不显示标准输入的内容（Silent mode）
COMMENT

printf "请输入一个值："
read key1  # 从标准输入读取数据
echo "输入的变量为：$key1"

printf "请输入三个值，用空格分割："
read key1 key2 key3 # 从标准输入读取3组字符串
echo "输入的变量为：$key1 $key2 $key3"

read -p "请输入用户名：" user # 设置一个提示信息
echo "用户名名为 $user"

read -t 3 -p "请输入用户名（必须3秒之内输入）：" user3s # 用-t设置超时时间，3秒后read命令自动退出
echo "输入的用户名为：[$user3s]"

read -n1 -p "按任意键：" key # 仅读取一个字符
echo "输入的键为：$key"

read -r -p "允许接收\\字符：" str # -r 选项支持读取\
echo "输入的字符串为：$str"

read -s -p "请输入密码（静默模式，不显示标准输入的内容）：" pass # 依然读取用户输入的数据，但是不显示出来
echo "输入的密码为：$pass"