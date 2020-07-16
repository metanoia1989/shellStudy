#!/bin/bash
# 功能描述：IFS对循环影响的演示

# 因为使用默认的IFS值，所以空格键为分隔符，变量X有4个值，for循环4次
echo -e "\e[32m案例1：未自定义IFS，对X=\"a b c d\"循环4次结束.\3[0m"
X="a b c d"
for i in $X
do
    echo "I am $i"
done

# 备份IFS分隔符
# 定义分隔符为分号，而X变量的值中没有分号分隔的数据，因此for仅循环1次
OLD_IFS="$IFS"
echo -e "\e[32m案例2：自定义IFS为分号，对X=\"1 2 3 4\"循环1次结束.\3[0m"
IFS=";"
X="1 2 3 4"
for i in $X
do
    echo "I am $i"
done

# 定义分隔符为分号，而X变量的值中也使用分号分隔，因此for循环4次
echo -e "\e[32m案例3：自定义IFS为分号，对X=\"Jacob;Rose;Vicky;Rick\"循环4次结束.\3[0m"
IFS=";"
X="Jacob;Rose;Vicky;Rick"
for i in $X
do
    echo "I am $i"
done

# 多个分隔符为或关系，最终循环次数为4次
IFS=";.:"
echo -e "\e[32m案例3：自定义IFS为分号|句号|冒号，对X=\"Jacob;Rose.Vicky:Rick\"循环4次结束.\3[0m"
X="Jacob;Rose.Vicky:Rick"
for i in $X
do
    echo "I am $i"
done