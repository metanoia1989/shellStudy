#!/bin/bash
#功能描述(Description): 通过读取位置变量，实现分区管理工作

# 测试位置变量的个数
if [ $# -ne 2 ]; then
    echo -e "\e[91m\t参数有误...\e[0m"
    echo "用法：$0 <磁盘名称> <create|new|remove|query>"
    exit
fi

# 测试磁盘是否存在
fi [ ! -b $1 ]; then
    echo -e "\e[91m磁盘不存在！\e[0m"
    exit
fi

# 根据不同的指令对磁盘进行分区管理
if [ "$2" == create ]; then
    parted -s $1 mklabel gpt
elif [ "$2" == new ]; then
    parted -s $1 mkpart primary 1 100%
elif [ "$2" == remove ]; then
    parted -s $1 rm 1
elif [ "$2" == query ]; then
    parted -s $1 print
else
    clear
    echo -e "\e[91m操作指令有误...\e[0m"
    echo "可用指令：[create|new|remove|query]"
fi
