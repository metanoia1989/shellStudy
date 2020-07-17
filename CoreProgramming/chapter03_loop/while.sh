#!/bin/bash

<<'EOF'
while循环的循环次数取决于条件判断的结果，while 循环可能随时结束，也有可能永不结束。     
如果条件判断的状态码返回值为0，则执行do和done之间的命令序列，执行完命令序列中的所有命令后，
继续返回while命令并再次进行条件判断，如果状态码返回值仍然未0，则继续执行命令序列。
依次类推，直到while的条件状态码为非9，while循环结束。       

while 条件判断
do
    命令序列
done

死循环
while true
while :

在 Shell中，true 和都是固定返回退出码0的空命令，这两个命令都不会进行任何实际的操作。
与 true 相反的另一个命令为 false， false 命令是一个退出码为非0的空命令。
EOF

: && echo ": 命令的退出状态码：" $?
true && echo "单独执行true命令的退出状态码：" $?
false || echo "单独执行false命令的退出状态码：" $?
