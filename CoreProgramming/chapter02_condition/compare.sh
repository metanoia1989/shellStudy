#!/bin/bash

<<'EOF'
用引号包括的标志符，这样注释里的特殊符号就不会被解析了  

在 Shell中可以使用多种方式进行条件判断如 `[[表达式]]`、`[表达式]` 或者 `test表达式`。
使用条件表达式可以测试文件属性，进行字符或数字的比较。需要注意的是，不管使用哪种方式进行条件判断，
系统默认都不会有任何输出结果，可以通过 `echo $?` 命令，查看上一条命令的退出状态码，
或者使用 && 和操作符结合其他命令进行结果的输出操作。

警告表达式两边必须有空格，否则程序会出错。
使用`[[]]`和`test`进行排序比较时，使用的比较符号不同。
在`test`或`[]`中不能直接使用`<`或`>`符号进行排序比较。


一行代码中输入多条命令，使用 `;` 分号、`&&`与、`||` 或 ，这三个符号将多个命令分隔。 
EOF

###############################################################
# 字符串的判断与比较
###############################################################
# test 和 [] 测试的效果一样，表达式中可以使用变量
test a == a # 测试字符串是否相等
echo "a == a " $? # 0表示正确 true，非0表示错误 false
test a == b; echo "a == b" $?
test a != b; echo "a != b" $? # 测试字符串是否不相等
[ $USER == metanoia1989 ]; echo "user == metanoia1989" $?
[ $USER == metanoia1989 ] && echo Y || echo N
[ $USER != metanoia1989 ] && echo Y || echo N

# -z 可以测试一个字符串是否为空
[ -z $TEST ] && echo Y || echo N
TEST=123456 # 定义变量并赋值
[ -z $TEST ] && echo Y || echo N

# [] 括号里面必须有空格，否则会报错
[test == beijing]
# == 左右也必须有空格，否则会被当做字符串吧
[ test==root ]; echo $?
[ 1==2 ]; echo $?

# 使用 -n 测试变量值字符串不为空时，需要将测试对象用双引号引起来
[ -n $Jacob ] && echo Y || echo N
# 等同于以下，空格也是有值的，永远为真
[ -n ] && echo Y || echo N
# 需要用双引号引起来
[ -n "$Jacob" ] && echo Y || echo N


###############################################################
# 字符串的判断与比较
###############################################################
<<'EOF'
比较两个数字可能的结果有等于、不等于、大于、大于或等于、小于、小于或等于这么几种情况。      
在 Shell脚本中支持对整数的比较判断，如下的符号进行比较运算。

-eq      等于   equal 
-ne      不等于  not equal
-gt      大于   greater than
-ge      大于或等于     greater than or equal
-lt     小于     less than
-le     小于或等于    less or equal
EOF

printf "3等于3吗 " && test 3 -eq 3 && echo Y || echo N
printf "3不等于3吗 " && test 3 -ne 3 && echo Y || echo N
printf "6大于4吗 " && test 6 -gt 4 && echo Y || echo N
printf "6大于9吗 " && test 6 -gt 9 && echo Y || echo N
printf "6大于或等于4吗 " && test 6 -ge 4 && echo Y || echo N
printf "6大于或等于6吗 " && test 6 -ge 6 && echo Y || echo N
printf "6小于9吗 " && test 6 -lt 9 && echo Y || echo N
printf "6小于3吗 " && test 6 -lt 3 && echo Y || echo N
printf "6小于6吗 " && test 6 -lt 6 && echo Y || echo N
printf "6小于或等于3吗 " && test 6 -le 3 && echo Y || echo N
printf "6小于或等于6吗 " && test 6 -le 6 && echo Y || echo N
printf "当前用户是metanoia1989吗 " &&  [ $UID -eq 1000 ]  && echo Y || echo N

###############################################################
# 文件属性的判断与比较
###############################################################
<<'EOF'
Shell 支持大量对文件属性的判断，常用的文件属性操作符很多。  

-e file     判断文件或目录是否存在，存在返回真，否则返回假
-f file     判断存在且为普通文件
-d file     判断存在且为目录
-b file     判断存在且为块设备文件（如磁盘，U盘等设备）
-c file     判断存在且为字符设备文件（如键盘、鼠标等设备）
-L file     判断存在且为软链接文件
-p file     判断存在且为命名管道
-r file     判断存在且当前用户对该文件具有可读权限
-w file     判断存在且当前用户对该文件具有可写权限
-x file     判断存在且当前用户对该文件具有可执行权限
-s file     判断存在且文件大小非空
file1 -ef file2     两个文件使用相同设备、相同inode编号，则返回真，否则返回假
file1 -nt file2     filel比file2更新时返回真；或者 filel在而file2不存在时返回真
file1 -ot file2     filel比file2更旧时返回真；或者file2存在而 filel不存在时返回真
EOF

touch ver1.txt
touch ver2.txt
mkdir test
printf "判断文件是否存在：" && [ -e ver1.txt ] && echo 对 || echo 错
printf "判断目录是否存在：" && [ -e test ] && echo 对 || echo 错
printf "判断文件是否不存在：" && [ ! -e test ] && echo 对 || echo 错
printf "判断存在，且为文件：" && [ -f ver1.txt ] && echo 对 || echo 错
printf "判断该文件不存在：" && [ ! -f ver1.txt ] && echo 对 || echo 错
printf "因为不是文件，结果错：" && [ -f test ] && echo 对 || echo 错
printf "判断存在，且为目录：" && [ -d test/ ] && echo 对 || echo 错
printf "因为不是目录，结果错：" && [ -d ver1.txt ] && echo 对 || echo 错
# 假设系统中有某个磁盘设备，使用-b测试该设备是否存在，且当该设备为块设备时返回值为真，否则返回值为假
printf "判断是否存在并为块设备：" && [ -b /dev/sda ] && echo 是 || echo 不是
printf "判断是否存在并为块设备：" && [ -b /etc/passwd ] && echo 是 || echo 不是
# 硬链接不可跨分区或磁盘创建，软链接可以        
ln -s /etc/hosts ~/hosts-soft-link # 创建软链接
ln /etc/hosts ~/hosts-hard-link # 创建硬链接
ls -l ~/hosts-soft-link
ls -l ~/hosts-hard-link
printf "判断是否为软链接：" && [ -L ~/hosts-soft-link ] && echo 是 || echo 否
printf "判断不是软链接：" && [ ! -L ~/hosts-soft-link ] && echo 是 || echo 否
printf "判断是否为软链接：" && [ -L ~/hosts-hard-link ] && echo 是 || echo 否
printf "判断两个文件是否使用相同的设备、inode编号：" && [ ~/hosts-hard-link -ef /etc/hosts ] && echo Y || echo N