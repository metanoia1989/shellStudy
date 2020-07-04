#!/bin/bash

# printf 格式化输出数据
# printf [格式] 参数
printf "%d\n" 12 # 屏幕显示整数 12
# printf "%d" jacob # jacob不是整数，所以会报错
printf "%5d\n" 12  # 右对齐
printf "%-5d\n" 12  # 左对齐
printf "|%-10d|\n" 12  # 左对齐效果
printf "|%10d|\n" 12  # 左对齐效果
printf "%o\n" 10  # 显示10的八进制
printf "%x\n" 10  # 显示10的十六进制
printf "%d\n" 0x11  # 将十六进制输出为十进制
printf "%d\n" 011 # 将八进制的11转换十进制
printf "%d\n" 9223372036854775808 
printf "%u\n" 9223372036854775808 # 无符号十进制数
printf "%f\n" 3.88 # 打印小数
printf "%.3f\n" 3.88 # 小数点后保留3位
printf "|%8.3f|\n" 3.88 # 右对齐，占用8位宽度
printf "|%-8.3f|\n" 3.88 # 左对齐，占用8位宽度
printf "%s\n" "hello" # 打印字符串
printf "|%10s|\n" "hello" # 右对齐，占用10位宽度
printf "|%-10s|\n" "hello" # 左对齐，占用10位宽度
printf "%s\t\t%s\n" "hello" "world" # 打印两个字符串