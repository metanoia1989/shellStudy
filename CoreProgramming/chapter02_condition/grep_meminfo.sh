#!/bin/bash

<<'EOF'
grep命令结合正则表达式，从meminfo文件中过滤当前系统剩余可用的内存容量，剩余容量以KiB为单位，
最后测试剩余可用容量是否小于或等于500MiB。
EOF

# grep -o  选项，仅显示匹配内容
grep MemFree /proc/meminfo | egrep -o "[0-9]+"
mem_free=$(grep MemFree /proc/meminfo | egrep -o "[0-9]+")
printf "内存是否小于500：" && [ $mem_free -le 512000 ] && echo Y || echo N

# 使用ps命令查看系统所有启动的进程列表信息，wc统计已经启动的进程数量
ps aux | wc -l
procs=$(ps aux | wc -l)
printf "进程数是否大于100：" && [ $procs -gt 100 ] && echo Y || echo N

# wc 命令统计/etc/passwd文件的行数，有多少行就表示有多少个账号
num=$(cat /etc/passwd | wc -l)
printf "当前系统账户数量是否大于或等于30个：" && [ $num -ge 30 ] && echo Y || echo N