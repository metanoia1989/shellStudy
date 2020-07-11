#!/bin/bash
#功能描述：交互脚本，识别用户的输入信息
#可以输入y或yes，不区分大小写
#可以输入n或no，不区分大小写
#使用|分隔多个模式匹配，表示或关系，匹配任意模式即可成功

read -p "你确定需要执行该操作吗(y|n)" key
case $key in
[Yy]|[Yy][Ee][Ss])
    echo "注意：你选择的是yes";;
[Nn]|[Nn][Oo])
    echo "注意：你选择的是no";;
*)
    echo "无效的输入";;
esac