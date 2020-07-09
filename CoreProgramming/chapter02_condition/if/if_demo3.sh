#!/bin/bash
# 脚本自动测试，如果某些操作无法完成则报错。非常使用的功能。             

if ! mkdir "/media/cdrom"; then
    echo "failed to create cdrom directory."
fi

if ! apt -y -q install ABC; then
    echo "failed to install soft."
fi