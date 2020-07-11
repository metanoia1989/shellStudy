#!/bin/bash
#功能描述：使用case进行字母比较

read -p "请输入一个a~c之间的字母：" key

case $key in
a)
    # 使用;;&会继续对后面的模式进行匹配
    echo "I am a.";;&  
b)
    echo "I am b.";;
a)
    # 使用会执行后一个模式匹配中的命令
    # 所以屏幕会继续显示 I am c.
    echo "I am aa.";& 
c)
    echo "I am c";;
a)
    echo "I am aaa.";;
*)
    echo "Out of range.";;
esac