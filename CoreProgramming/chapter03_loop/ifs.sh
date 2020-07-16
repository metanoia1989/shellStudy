#!/bin/bash

<<'EOF'
在 Shell中使用内部变量ifs（Internal Field Seprator）来决定项目列表或值列表的分隔符，

IFS的默认值为空格、Tab制表符或换行符。

使用for循环读取项目列表或值列表时， 就会根据IFS的值判断列表中值的个数，最终决定循环的次数。
例如，A＝＂hello the world＂，当使用空格作分隔符时，变量A的值有三列。
但是，当使用字母t作为分隔符时，变量A的值就有两列。
所以当使用不同的分隔符时读取数据的结果也会有很大差别，这点在编写脚本时一定要注意！

IFS的多个值之间是“或”关系，所以for循环在读取列表时，数据可以使用空格分隔，
或使用Tab制表符分隔，或使用换行符对数据进行分隔。
因为空格、Tab制表符和换行符都属于 ASCII码表中的控制字符，是不可显示的内容，
所以正常使用echo命令显示该变量的值时，是看不到内容的，但是可以通过od命令将数据转换为八进制数据后再查看。 
EOF

<<'EOF'
注意，当使用echo命令输出IFS的值时，因为IFS的值是空格或Tab制表符，所以无法显示具体内容。
另外，因为IFS的值还可以是一个换行符，所以输出结果可以是一个独立的空白行，
而echo命令在输出数据内容后又会自动进行一次换行，所以最后输出两个空白行！
如果使用 printf命令输出IFS值，就不会有两个空白行的情况发生，因为 printf打印完内容后默认不换行。
EOF
echo "IFS的值是：$IFS"
printf "IFS的值是：%s" $IFS
echo  -e "\n"
printf "使用od命令将数据转换为八进制后查看：" && printf "%s" "$IFS" | od -b

# IFS的原始值不容易设置，当需要修改IFS值时，需要提前备份原始值
OLD_IFS="$IFS"
IFS=":"
read -p "请输入3个数据（分隔符为:）：" x y z
echo "x: $x" 
echo "y z: $y $z" 

IFS=','
x='';y='';z=''
read -p "请输入3个数据（分隔符为,）：" x y z
echo "x: $x" 
echo "y z: $y $z" 

IFS="$OLD_IFS"