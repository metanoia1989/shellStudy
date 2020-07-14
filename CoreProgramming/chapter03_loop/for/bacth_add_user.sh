#!/bin/bash
# 功能描述：通过读取用户列表文件批量创建系统账户

for i in `cat user.txt`
do
    if id $i &>/dev/null; then
        echo "$i, 该账户已存在！"
    else
        useradd $i
        echo "$i:123456"  | sudo chpasswd
    fi
done