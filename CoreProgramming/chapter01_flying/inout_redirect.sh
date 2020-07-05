#!/bin/bash

# 标准输入输出重定向        

<<COMMENT
标准输出 1 标准错误输出 2 标准输入 0
重定向标准输出到文件 > or >> 等于 1> or 1>>
重定向标准错误输出到文件 2> or 2>>
同时重定向标准输出和错误输出 &> or &>>
重定向标准错误到标准输出 2>&1
重定向标准输出到标准错误 1>&2
/dev/null 流黑洞，重定向到这里的输入全部被丢弃掉  

输入重定向 < 解决脚本自动化处理程序输入的问题
$mail -s warning root@localhost < /etc/hosts # 非交互发送邮件

Here Document <<
命令 << 分隔符
内容
分隔符
系统会自动将两个分割符之间的内容重定向传递给前面的命令，作为命令的输入。推荐使用EOF end of file
COMMENT

# 创建新文件，导出数据到文件
echo "hello the world" > test.txt
cat test.txt

# 覆盖重定向，前面的数据丢失
echo "Jacob Shell Scripts" > test.txt
cat test.txt

# 追加重定向，数据不丢失
echo "test file" >> test.txt
cat test.txt

# ls 查看不存在的文件，会有错误输出
ls -l /nofiles 2> test.txt # 错误输出重定向，覆盖数据
ls -l /oops 2>> test.txt # 错误重定向，追加数据
cat test.txt

# 同时重定向标准输出和标准错误输出
ls -l /etc/hosts /nofile > ok.txt 2> error.txt
cat ok.txt error.txt
ls -l /etc/hosts /nofile &> test.txt
ls -l /etc/passwd /oops &>> test.txt
cat test.txt

# 将标准错误重定向到标准输出，将标准输出重定向到标准错误
ls /nofile 2>&1
echo "hello" 1>&2

# 标准错误重定向到标准输出，然后将标准输出重定向到文件
ls /etc/passwd /nofile > test.txt 2>&1
cat test.txt

# /dev/null
echo "hello" > /dev/null
ls /nofile 2>/dev/null
ls /etc/hosts /nofile &>/dev/null


# cat 通过Here Document读取数据
cat > test.txt << HERE
该文件为测试文件。
测试完毕后，记得将该文件删除。
Welcome to Earth.
HERE