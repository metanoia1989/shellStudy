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
# irq 中断
# cs 上下文切换
# usertime 用户态CPU
# system 系统态CPU
# iowait 等待IO时间
irq=$(vmstat 1 2 | tail -n +4 | tr -s" " | cut -d" " -f12)
cs=$(vmstat 1 2 | tail -n +4 | tr -s" " | cut -d" " -f13)
usertime=$(vmstat 1 2 | tail -n +4 | tr -s" " | cut -d" " -f14)
systime=$(vmstat 1 2 | tail -n +4 | tr -s" " | cut -d" " -f15)
iowait=$(vmstat 1 2 | tail -n +4 | tr -s" " | cut -d" " -f17)

echo "$irq $cs $usertime $systime $iowait"

# 当剩余内存不足1G时发送邮件给root报警
[ $free_mem -lt 1048576 ] && echo "$local_time Free memory not enough.
Free_mem: $free_mem on $local_ip" | \
mail -s Warning root@localhost

# 当CPU的15分钟负载均衡超过4时 发送邮件给root报警
result=$(echo "$cpu_load > 4" | bc)
[ $result -eq 1 ] && echo "$local_time CPU load to high 
CPU 15 averageload: $cpu_load on $local_ip" | \
mail -s Warning root@localhost

# 当系统实时在线人数超过3人时发送邮件给root报警
[ $login_user -gt 3 ] && echo "$local_time Too many user.
$login_user users login to $local_ip" | \
mail -s Warning root@localhost

# 当实时进程数量大于500时发送邮件给root报警
[ $procs -gt 500 ] && echo "$local_time Too many procs.
$procs proc are runing on $local_ip" | \
mail -s Warning root@localhost

# 当实时CPU中断数量大于5000时发送邮件给root报警
[ $irq -gt 5000 ] && \
echo "$local_time Too many interupts.
There are $irq interupts on $local_ip" | \
mail -s Warning root@localhost

# 当实时CPU上下文切换数量大于5000时发送邮件给root报警
[ $cs -gt 5000 ] && \
echo "$local_time Too many Content Switches.
$cs of context switches per second on $local_ip" | \
mail -s Warning root@localhost

# 当用户态进程占用超70%时发送邮件给root报警
[ $username -gt 70 ] && \
echo "$local_time CPU load to high.
Time spend running non-kernel code: $usertime on $local_ip" | \
mail -s Warning root@localhost

# 当内核态进程占用CPU超70%时发送邮件给root报警
[ $systime -gt 70 ] && \
echo "$local_time CPU load to high.
Time spend running non-kernel code: $systime on $local_ip" | \
mail -s Warning root@localhost

# 当CPU消耗大量时间等待磁盘IO时发送邮件给root报警
[ $iowait -gt 40 ] && \
echo "$local_time Disk to slow.
CPU spend too many time wait disk I/O: $iowait on $local_ip" | \
mail -s Warning root@localhost