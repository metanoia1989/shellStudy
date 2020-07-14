#!/bin/bash
# 功能描述：测试某个网段内所有主机的连通性
# 可以使用 $() 或 `` 对命令进行扩展

net="192.168.0"
# for i in $(seq 254)
for i in `seq 254`
do 
    ping -c2 -i0.4 -W1 $net.$i &>/dev/null
    if [ $? -eq 0 ];then
        echo "$net.$i is up."
    else
        echo "$net.$i is down."
    fi
done