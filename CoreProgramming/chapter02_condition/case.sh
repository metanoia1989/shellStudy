#!/bin/bash
<<'EOF'
case语句可以将某个关键词与预设的一系列值进行模式匹配

case语句的格式如下：
case word in
模式1)
    命令序列1;;
模式2)
    命令序列2;;
......
*)
    命令序列n;;
esac

case支持多个条件的匹配：
case word in
模式1|模式2|模式3)
    命令序列1;;
模式4|模式5|模式6)
    命令序列2;;
... ...
*)
    命令序列n;;
esac

word关键词展开支持使用~根目录、变量展开$、算术运算符展开$[]、命令展开$()
每个模式匹配中也都支持与word关键字一样的展开功能。

case命令首先会展开word关键字，然后将该关键字与下面的每个模式进行匹配比较。
word关键字展开支持使用 ~（根目录）、变量展开$、算术运算展开$[]、命令展开$()等。
每个模式匹配中也都支持与ord关键字一样的展开功能。
一旦case命令发现有匹配的模式，则执行对应命令序列中的命令。
如果命令序列的最后使用了;;（双分号），则case命令不再对后续的模式进行匹配比较，即匹配停止。
如果使用 ;& 替代 ;; 会导致case继续执行下一个模式匹配中附加的命令序列。
如果使用 ;;& 替代 ;; 则会导致case继续对下一个模式进行匹配，如果匹配则执行对应命令序列中的命令。

case模式匹配支持通配符：
*       匹配任意字符串
?       匹配任意单个字符
[...]   匹配括号中的任意单个字符，使用-可以表示连续的字符；
        [后面使用或^表示匹配不在括号中的所有其他内容；
        [] 中还支持POSIX标准字符类，如[:alnum:] [:digit:]、[:lower:] 等   

使用[A-Z]这样的排序集合时，Shell默认会根据系统的locale字符集排序，如果字符集使用不当，会导致匹配不到任何数据的情况发生。    
$ localectl status # 查看字符集
$ localectl list-locales | grep en # 显示字符集列表
$ localectl set-locale "LANG=zh_CN.UTF-8" # 设置语言字符集
$ localectl set-locale "LANG=en_US.UTF-8" # 设置语言字符集

shopt -s extglob 开启 bash 的扩展通配符

扩展通配符      描述
?(模式列表)     匹配0次或1次指定的模式列表
+(模式列表)     匹配1次或多次指定的模式列表
*(模式列表)     匹配0次或多次指定的模式列表
@(模式列表)     仅匹配1次指定的模式列表
!(模式列表)     匹配指定模式列表之外的所有内容
EOF

# 功能描述：定义功能菜单，使用 case 语句判断用户选择的菜单项，实现对应的功能

clear
echo -e "\033[42m-------------------------------------\033[0m"
echo -e "\e[2;10H这里是菜单\t\t#"
echo -e "#\e[32m 1. 查看网卡信息 \e[0m              #"
echo -e "#\e[33m 2. 查看内存信息 \e[0m              #"
echo -e "#\e[34m 3. 查看磁盘信息 \e[0m              #"
echo -e "#\e[35m 4. 查看CPU信息 \e[0m               #"
echo -e "#\e[36m 5. 查看账户信息 \e[0m              #"
echo -e "\033[42m-------------------------------------\033[0m"
echo 

read -p "请输入选项[1~5]:" key
case $key in
1)
    ifconfig | head -2;;
2)
    mem=$(free | grep Mem | tr -s " " | cut -d" " -f7)
    echo "本机内存剩余容量为：${mem}K.";;
3)
    root_free=$(df | grep /$ | tr -s " " | cut -d" " -f4)
    echo "本机根分区剩余容量为：${root_free}K.";;
4)
    cpu=$(uptime | tr -s " " | cut -d" " -f11)
    echo "本机CPU 15min 的平均负载为: $cpu.";;
5)
    login_number=$(who | wc -l)
    total_number=$(cat /etc/passwd | wc -l)
    echo "当前系统账号为$USER"
    echo "当前登录系统的账户数量为：$login_number"
    echo "当前系统中总用户数量为：$total_number";;
*)
    echo "输入有误，超出1~5的范围";;
esac