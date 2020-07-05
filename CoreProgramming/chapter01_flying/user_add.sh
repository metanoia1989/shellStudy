#!/bin/bash

# 使用 read 命令编写一个添加用户的脚本
# Read User's name and password from standart input.

read -p "请输入用户名：" user
read -s -p "请输入密码：" pass
sudo useradd "$user"
echo "$user:$pass" | sudo chpasswd
echo "创建用户$user成功"