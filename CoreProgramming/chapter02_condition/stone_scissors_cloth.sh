#!/bin/bash
# 将数据抽象为计算机善于处理的数字
# 功能描述：石头剪刀布游戏
# 计算机根据生成的随机数出拳，并提示用户出拳
# 将用户的输入与计算机产生的随机数进行比较，判断输赢
# 1：石头，2：剪刀，3：布（随机数对3求模后，再加1的结果为1 2 3）
computer=$[$RANDOM % 3 + 1]

clear
echo "#################################"
echo "#        石头剪刀布游戏         #"
echo -e "#\e[32m    请根据下列提示出拳：       \e[0m#"
echo "#################################"
echo "|-----------------|"
echo "| 1. 石头         |"
echo "| 2. 剪刀         |"
echo "| 3. 布           |"
echo "|-----------------|"
read -p "请输入1~3的值：" person
clear

case $person in
1)
    if [ "$computer" == 1 ]; then
        echo " _________________ "
        echo "| 出拳：石头       |"
        echo "| 计算机出拳：石头 |"
        echo "|_________________|"
        echo -e "\e[32m平局.\e[0m"
    elif [ "$computer" == 2 ]; then
        echo " _________________ "
        echo "| 出拳：石头       |"
        echo "| 计算机出拳：剪刀 |"
        echo "|_________________|"
        echo -e "\e[32m恭喜，你赢了.\e[0m"
    elif [ "$computer" == 3 ]; then
        echo " _________________ "
        echo "| 出拳：石头       |"
        echo "| 计算机出拳：布 |"
        echo "|_________________|"
        echo -e "\e[32m计算机赢.\e[0m"
    fi;;
2)
    if [ "$computer" == 1 ]; then
        echo " _________________ "
        echo "| 出拳：剪刀       |"
        echo "| 计算机出拳：石头 |"
        echo "|_________________|"
        echo -e "\e[32m计算机赢.\e[0m"
    elif [ "$computer" == 2 ]; then
        echo " _________________ "
        echo "| 出拳：剪刀       |"
        echo "| 计算机出拳：剪刀 |"
        echo "|_________________|"
        echo -e "\e[32m平局.\e[0m"
    elif [ "$computer" == 3 ]; then
        echo " _________________ "
        echo "| 出拳：剪刀      |"
        echo "| 计算机出拳：布  |"
        echo "|________________|"
        echo -e "\e[32m恭喜，你赢了.\e[0m"
    fi;;
3)
    if [ "$computer" == 1 ]; then
        echo " _________________ "
        echo "| 出拳： 布       |"
        echo "| 计算机出拳：石头 |"
        echo "|_________________|"
        echo -e "\e[32m恭喜，你赢了.\e[0m"
    elif [ "$computer" == 2 ]; then
        echo " _________________ "
        echo "| 出拳：布       |"
        echo "| 计算机出拳：剪刀 |"
        echo "|_________________|"
        echo -e "\e[32m计算机赢.\e[0m"
    elif [ "$computer" == 3 ]; then
        echo " _________________ "
        echo "| 出拳：布       |"
        echo "| 计算机出拳：布 |"
        echo "|_________________|"
        echo -e "\e[32m平局.\e[0m"
    fi;;
*)
    echo -e "\e[91m无效的输入值，请输入1~3范围内的值\e[0m"
esac