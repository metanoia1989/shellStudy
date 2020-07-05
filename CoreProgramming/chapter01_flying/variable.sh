#!/bin/bash

<<COMMENT
变量名必须是字母、数字和下划线组合，并且不能是数字开头
定义变量时等号两边不可以有空格，并且定义变量无需$符号
读取变量值时使用$符号，变量名与其他非变量名的字符混在一起时，使用{}分隔
使用unset可以取消变量的定义
COMMENT


test=123 # 定义变量
echo $test # 调用变量，提取变量的值
echo $testRMB # 读取没有的变量，返回空
echo ${test}RMB
echo $test-yuan
echo $test:yuan
echo $test yuan
unset test # 取消变量定义
echo $test # 返回的结果为空

# 描述信息：下面的脚本主要获取主机的数据信息（内存、网卡IP、CPU负载）
<<COMMENT
tr -s " " 把连续多个空格合并为一个
cut -d " " -f num 以指定字符为分隔符，获取指定数字的列
COMMENT
localip=$(ifconfig eth0 | grep netmask | tr -s " " | cut -d" " -f3)
mem=$(free | grep Mem | tr -s " " | cut -d" " -f7)
cpu=$(uptime | tr -s " " | cut -d" " -f11)
echo "本机IP地址是：$localip"
echo "本机内存剩余容量为：$mem"
echo "本机CPU 15min的平均负载为：$cpu"

echo "aaa bbb" | tr -s "a" # 将多个连续的a合并为一个a
echo "a---b---c" | tr -s "-" # 将多个连续的-合并为一个-
echo "A B C" | cut -d" " -f2 # 以空格为分隔符，获取第二列
echo "A-B-C" | cut -d"-" -f3 # 以-为分隔符，获取第三列
echo "AcBcC" | cut -d"c" -f2 # 以c为分隔符，获取第二列