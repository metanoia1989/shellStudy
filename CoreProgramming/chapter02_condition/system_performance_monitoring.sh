#!/bin/bash

<<'EOF'
检测系统环境、监控系统性能的脚本，并判断各项数据指标是否符合预设的阈值。
如果数据有异常，那么将结果通过邮件发送给本机root账户。
在实际生产环境能联网的情况下，也可以发送邮件给某个外网的邮件账户。

过滤数据使用 cut 命令，使用 awk 命令更加高效。  
EOF

# 变量定义列表如下
# local_time 时间
# local_ip eho0网卡IP
# free_mem 剩余内存
# free_disk 剩余磁盘
# cpu_load 15分钟平均负载
# login_user 登录系统的用户
# procs 当前进程数量
local_time=$(date +"%Y%m%d %H:%M:%S")
local_ip=$(ifconfig wifi0 | grep netmask | tr -s " " | cut -d" " -f3)
free_mem=$(cat /proc/meminfo | grep MemFree | tr -s " " | cut -d" " -f2)
free_disk=$(df | grep "/\$" | tr -s " " | cut -d" " -f4)
cpu_load=$(cat /proc/loadavg | cut -d" " -f3)
login_user=$(who | wc -l) 
procs=$(ps aux | wc -l)

<<'EOF'
vmstat 命令可以查看系统中CPU的中断数，上下文切换数量
CPU处于IO等待的时间，用户态系统消耗的CPU统计数据

vmstat 命令输出的前2行是头部信息，第3行为开机到当前的平均数据，
第4行开始的数据是每秒实时数据，tail -n +4 表示去掉前三行从第四行开始显示
EOF