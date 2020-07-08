#!/bin/bash

<<'EOF'
对于简单的条件判断，结合 && 和 || 就可以完成大量的脚本。
但是当脚本越写越复杂、功能越写越完善时，简单的 && 和 || 就不足以满足需求了。
此时，选择使用if语句结合各种判断条件，功能会更加完善和强大。
在Shell脚本中if语句有三种格式，分别是单分支if语句、双分支if语句和多分支if语句。

就是主流编程语言的分支结构，if...else...的语法

单分支if语句的语法格式：
if 条件测试
then
    命令序列
fi

多条命令写在一行可以用`;`分号来分隔，所以if和then也可以写在一行。   
if 条件测试; then
    命令序列
fi

条件测试可以是：字符串的比较测试、数字的比较测试、文件或目录属性的测试，也可以是一条或多条命令。    
EOF

# 几个相关的简单例子参见 if 文件夹