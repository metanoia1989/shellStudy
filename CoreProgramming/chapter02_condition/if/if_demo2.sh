#!/bin/bash
# 计算计算机的CPU品牌是AMD还是Intel
# grep 的 -q 选项，可以让 grep 进入静默模式，不管是否获取数据，都不显示输出结果。
# if 命令会通过grep命令的返回值自动判断是否获取数据

if grep -q AMD /proc/cpuinfo; then
    echo "AMD CPU"
fi

if grep -q Intel /proc/cpuinfo; then
    echo "Intel CPU"
fi