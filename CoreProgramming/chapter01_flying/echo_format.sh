#!/bin/bash
#定义输出的字体颜色、样式、背景和位置

echo "\t" # 没有-e选项不支持转义
echo -e "hello\tworld"
echo -e "helle\bo world" # 退格
echo -e "helle\fworld" # 换行，但是光标依然停留在原来的位置
echo -e "hello\nworld" 
echo -e "hello\rworld"  # 光标返回行首
echo -e "\\" # 输出 \ 符号
echo -e "\033[1mOK\033[0m" # 输出粗体字符串

echo -e "\033[1m粗体" # 加粗显示OK后没关闭属性设置
echo -e "\e[1m粗体\e[0m" # \e 与 \033 效果一致
echo -e "\e[4m下划线\e[0m" # 加下划线输出
echo -e "\e[5m闪烁显示\e[0m" 

echo -e "\e[30m黑色显示\e[0m" 
echo -e "\e[31m红色显示\e[0m" 
echo -e "\e[32m绿色显示\e[0m" 
echo -e "\e[33m棕色显示\e[0m" 
echo -e "\e[34m蓝色显示\e[0m" 
echo -e "\e[35m紫色显示\e[0m" 
echo -e "\e[36m紫绿色显示\e[0m" 
echo -e "\e[37m亮灰色显示\e[0m" 
echo -e "\e[1;33m亮黄色显示\e[0m" 
echo -e "\e[42m绿色背景显示\e[0m" 
echo -e "\e[44m蓝色背景显示\e[0m" 
echo -e "\e[32;44m绿色字体，蓝色背景显示\e[0m" 

echo -e "\033[2;10H第2行第10列显示"
echo -e "\033[3H第3行开头位置显示"