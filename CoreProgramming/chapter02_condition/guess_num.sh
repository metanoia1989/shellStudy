#!/bin/bash
<<'EOF'
在Linu系统中有一个内置环境变量，变量名称为 RANDOM，该变量的值是0～32767之间的随机整数。
通过求模运算，可用将数字变为我们需要的范围。
比如，对10求模，可以获取0～9之间的整数:
对100求模的结果永远是0～9之间的整数；
对33求模后再加1，结果永远是1～33之间的整数。
EOF
# 功能描述(Description): 脚本自动生成10以内的随机数，根据用户的输入，判断输出结果

clear
num=$[RANDOM % 10 + 1]
read -p "请输入1~10之间的整数：" guess

if [ $guess -eq $num ]; then
    echo "恭喜，猜对了，就是 $num"
elif [ $guess -lt $num ]; then
    echo "Oops，猜小了"
else
    echo "Oops，猜大了"
fi