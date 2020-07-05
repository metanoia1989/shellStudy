#!/bin/bash

<<COMMENT
"" 双引号，引用一个整体
'' 单引号，引用一个整体，屏蔽特殊符号，转化为字符表面的名义
\ 转义符号，屏蔽器后面的第一个符号的特殊含义
$$ 显示当前进程号
& 符号默认为后台进程
* 通配符
~ 用户根目录
() 为函数调用符号
`` 命令替换，获取命令输出的结果替换命令本身的字符串。不支持嵌套
$() 支持嵌套的命令替换
COMMENT
touch "a b c"
rm "a b c"

echo #
echo '####' # 使用单引号屏蔽#的含义
test=8
echo $test RMB
echo '$test RMB' # 单引号屏蔽$符号的含义
a=11
b=22
echo \$a\$b

echo $$
echo '$$'
echo '&'
echo \*
echo '~'
echo '()' 

tar -czf ~/log-`date +%Y%m%d`.tar.gz /var/log
echo "当前系统账号登录数量：`who | wc -l`"
kill `cat /var/run/atd.pid` # 杀死atd进程

ls /etc/*.conf

tar -czf ~/conf.tar.gz `ls /etc/*.conf` # 将多个文件压缩打包为一个文件
tar -tf ~/conf.tar.gz # 查看压缩包中的文件列表

echo "当前系统账号登录数量：$(who | wc -l)"
ping -c2 $(hostname)
touch $(date +%Y%m%d).txt
echo "当前系统进程数量：$(ps aux | wc -l)"
echo $(echo 我是1级嵌套 $(echo 我是二级嵌套))