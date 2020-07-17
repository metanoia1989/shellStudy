#!/bin/bash
# 功能描述：while循环语句基本语法演示
# 通过 grep 过滤 Httpd，检测 Httpd 服务是否为启动状态

while ps aux | grep -v grep | grep -q httpd
do
    clear
    echo "      Httpd 运行状况          "
    echo "------------------------------"
    echo -e "\e[32mHttp正在运行中...\e[0m"
    echo "------------------------------"
    sleep 0.5 
done
    echo "Httpd 被关闭"