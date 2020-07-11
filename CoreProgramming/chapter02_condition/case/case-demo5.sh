#!/bin/bash
# 演示扩展通配符的作用

shopt -s extglob

read -p "请输入与任意字符：" key
case $key in
+([Yy]))
?([Nn])o)

*)
esac