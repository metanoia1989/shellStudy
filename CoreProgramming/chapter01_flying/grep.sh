#!/bin/bash

<<COMMENT
grep 命令可以查找关键词并打印匹配的行
grep [选项] 匹配模式 [文件]
常用选项：
-i 忽略字母小写
-v 取反匹配
-w 匹配单词
-q 静默匹配，不将结果显示在屏幕上
COMMENT

grep th test.txt # 在test.txt文件中过滤包含th关键词的行
grep -i the test.txt # 过滤包含the关键词的行（不区分字母大小写）
grep -w num test.txt # 进过滤num关键词（不会过滤number关键词）
grep -v the test.txt # 过滤不包含the关键词的行
grep -q root /etc/passwd # 不在屏幕上显示过滤的结果


#######################################################################   
# 正则表达式使用
#######################################################################   

<<COMMENT
基本正则表格式及其含义
c           匹配字母c
.           匹配任意单个字符
*           匹配前一个字符出现零次或多次
.*          匹配多个任意字符
[]          匹配集合中的任意单个字符，括号可以是任意数量字符的集合
[x-y]       匹配连续的字符串范围
^           匹配字符串的开头
$           匹配字符串的结尾
[^]         匹配否定，对括号中的集合取反
\           匹配转义后的字符串
\{n，m\}    匹配前一个字符重复n到m次
\{n,\}      匹配前一个字符重复至少n次
\{n\}       匹配前一个字符重复n次
\(\)        将\(与\)之间的内容存储在“保留空间”，最多可存储9个
\n          通过\1至\9调用保留空间中的内容
COMMENT

echo '## grep 过滤 /etc/passwd 文件 ##'

echo "查找包含root的行："
grep "root" /etc/passwd  

echo "查找:与0:之间任意两个字符的字符串："
grep ":..0:" /etc/passwd 

echo "查找包含至少一个0的行（第一个0必须出现，第二个0可以出现0此或多次）"
grep "00*" /etc/passwd

echo "查找包含oot或ost的行"
grep "o[os]t" /etc/passwd

echo "查找包含0-9数字的行"
grep "[0-9]" /etc/passwd

echo "查找包含f-q字母的行"
grep "[f-q]" /etc/passwd

echo "查找以root开头的行"
grep "^root" /etc/passwd

echo "查找以sh结尾的行"
grep "sh$" /etc/passwd

echo "查找sbin/后面不跟n的行"
grep "sbin/[^n]" /etc/passwd

echo "查找数字0出现最少1次、最多2次的行"
grep "0\{1,2\}" /etc/passwd

echo "查找两个root之间可以是任意字符的行"
grep "\(root\).*\1" /etc/passwd

echo "过滤文件的空白行"
grep "^$" /etc/passwd

echo "过滤文件的非空白行"
grep -v "^$" /etc/passwd

#######################################################################   
# 扩展正则表达式 Extended Regular Expression
#######################################################################   
<<COMMENT
{n, m}  等同于基本正则表达式的\{n, m\}
+       匹配前的字符出现一次或多次
?       匹配前的字符出现零次或一次
|       匹配逻辑或，即匹配前或后的字串
()      匹配正则集合，同时也有保留的意思，等同于基本正则表达式的
COMMENT
echo "查找数字0出现最少1次最多2次的行"
egrep "0{1,2}" /etc/passwd
echo "查找包含至少一个0的行"
egrep "0+" /etc/passwd
echo "查找包含root或者admin的行"
egrep "(root|admin)" /etc/passwd

#######################################################################   
# POSIX规范的正则表达式，可以解决语系问题，比如a-z仅能匹配英文字母
#######################################################################   
<<COMMENT
字符集含义
[alpha:]    字母字符            [:graph:]   非空格字符
[:alnum:]   字母与数字字符       [:print:]  任意可以显示的字符
[:cntrl:]   控制字符             [:space:]  任意可以产生空白的字符
[:digit:]   数字字符             [:blank:]  空格与Tab键字符
[:xdigit:]  十六进制数字字符      [:lower:] 小写字符
[:punct:]   标点符号             [:upper:] 大写字符
COMMENT
echo "匹配任意数字"
grep "[[:digit:]]" /etc/passwd


#######################################################################   
# GNU规范的正则表达式
#######################################################################   
<<COMMENT
Linux中的GNU软件一般支持转义元字符，这些转义元字符有：
\b      边界字符，匹配单词的开始或结尾
\B      与\b为反义词，\Bthe \B不会匹配单词the，仅会匹配the在中间的单词，如 atheist
\w      等同于 [_[:alnum:]] 
\W      等同于 [^_[:alnum:]] 
另外有部分软件支持
\d      表示任意数字
\D      表示任意非数字
\s      表示任意空白字符（空格、制表符等）
\S      表示任意非空白字符
COMMENT
echo "匹配i结尾的单词"
grep "i\b" /etc/passwd

echo "匹配所有非字母、数字及下划线组合的内容"
grep "\W" /etc/passwd

echo "匹配所有字母、数字及下划线组合的内容"
grep "\w" /etc/passwd

echo "支持perl兼容的正则 -P"
grep -P --color "\d" /etc/passwd
grep -P --color "\D" /etc/passwd