#!/bin/bash

<<'EOF'
[[]] 和 [] 的区别
多数情况下`[]`和`[[]]`是可以通用的，两者的主要差异是：
test 或 `[]`是符合 POSIX 标准的测试语句，兼容性更强，几乎可以运行在所有 Shell解释器中，
相比较而言 `[[]]` 仅可运行在特定的几个 Shell 解释器中（如Bash、Zsh等）。
事实上，目前支持使用进行条件测试的解释器已经足够多了。使用`[[]]`进行测试判断时甚至可以使用正则表达式。

[[]] 和 [] 的差异汇总信息
[[]]测试        []测试
< 排序比较      排序比较不支持（仅部分 Shell解释器支持k）
> 排序比较      排序比较不支持（仅部分 Shell解释器支持＞）
&& 逻辑与       -a 逻辑与
|| 逻辑或       -o 逻辑或
== 模式匹配     == 字符匹配
=~ 正则匹配     不支持
() 分组测试     \(\) 仅部分 Shell解释器支持分组测试
EOF

# [[]] 和 [] 的通用表达式
printf "5 -eq 5：" && [[ 5 -eq 5 ]] && echo Y || echo N
printf "5 -ne 5：" && [[ 5 -ne 5 ]] && echo Y || echo N
printf "5 -gt 8：" && [[ 5 -gt 8 ]] && echo Y || echo N
printf "5 -lt 8：" && [[ 5 -lt 8 ]] && echo Y || echo N
printf " -r /etc/hosts：" && [[ -r /etc/hosts ]] && echo Y || echo N
printf " ver1.txt -nt ver2.txt：" && [[ ver1.txt -nt ver2.txt ]] && echo Y || echo N
printf " ver1.txt -ot ver2.txt：" && [[ ver1.txt -ot ver2.txt ]] && echo Y || echo N

<<'EOF'
[[]] 和 [] 的差异点
在 `[[]]` 中使用 `<` 和 `>` 符号时，系统进行的是排序操作，
而且支持在测试表达式内使用 `&&` 和 `||` 符号。
在 test 或 `[]` 测试语句中不可以使用 `&&` 和 `||` 符号。

注意 `[[]]` 中的表达式如果使用 `<` 或 `>` 进行排序比较，使用的是本地的 locale 语言顺序。
可以使用LANG＝C设置在排序时 ASCII 使用标准的码顺序。

在 ASCII 码的顺序中，小写字母顺序码 > 大写字母顺序码 > 数字顺序码。
EOF

LANG=C # 防止其他语系导致排序混乱
printf "小写字母顺序码大于大写字母顺序码 b > A：" && [[ b > A ]] && echo Y || echo N 
printf "大写字母顺序码大于数字顺序码 A > 6：" && [[ A > 6 ]] && echo Y || echo N 
printf "大写字母顺序码大于小写字母顺序码 A > b：" && [[ A > b ]] && echo Y || echo N 
printf "数字顺序码大于大写字母顺序码 8 > C：" && [[ 8 > C ]] && echo Y || echo N 
printf "8 > 2：" && [[ 8 > 2 ]] && echo Y || echo N 
printf "2 > 8：" && [[ 2 > 8 ]] && echo Y || echo N 
printf "T > F：" && [[ T > F ]] && echo Y || echo N 
printf "m > c：" && [[ T > F ]] && echo Y || echo N 

<<'EOF'
逻辑操作 与 或 

虽然 `[]` 也支持同时进行多个条件的逻辑测试，但是在 `[]` 中需要使用 `-a` 和 `-o` 进行逻辑与和逻辑或的比较操作，
而 `[[]]` 中可以直接使用 `&&` 和 `||` 进行逻辑比较操作，更直观，可读性更好。

A && B 或者 A -a B，意思是仅当A和B两个条件测试都成功时，整体测试结果才为真。
A || B 或者 A -o B，意思是只要A或B中的任意一个条件测试成功，则整体测试结果为真。
EOF
printf "yes == yes -a no == no：" && [ yes == yes -a no == no ] && echo Y || echo N
printf "yes == y -a no == no：" && [ yes == y -a no == no ] && echo Y || echo N
printf "yes == y -o no == no：" && [ yes == y -o no == no ] && echo Y || echo N
printf "yes == yes -o no == no：" && [ yes == yes -o no == no ] && echo Y || echo N
printf "yes == yes && no == no：" && [[ yes == yes && no == no ]] && echo Y || echo N
printf "yes == y && no == no：" && [[ yes == y && no == no ]] && echo Y || echo N
printf "yes == yes || no == no：" && [[ yes == yes || no == no ]] && echo Y || echo N
printf "yes == y || no == no：" && [[ yes == y || no == no ]] && echo Y || echo N
[[ A == A && 6 -eq 6 && C == C ]]; echo $? # 返回0表示正确
[[ A == A && 6 -eq 3 && C == C ]]; echo $? # 返回非0表示错误

<<'EOF'
需要注意的还有 == 比较符，在 [[]] 中 == 是模式匹配，模式匹配允许使用通配符。例如，Bash常用的通配符有*、?、[...]等。
而 == 在test句中仅代表字符串的精确比较，判断字符串是否一模一样。
EOF
name=Jacob
printf "$name == J*：" && [[ $name == J* ]] && echo Y || echo N
printf "$name == A*：" && [[ $name == A* ]] && echo Y || echo N
printf "$name == J?cob：" && [[ $name == J?cob ]] && echo Y || echo N
printf "判断a是否是小写字母：" && [[ a == [a-z] ]] && echo Y || echo N
printf "判断a是否是数字：" && [[ a == [0-9] ]] && echo Y || echo N
# == 在 [] 中进行的是字符串的比较操作，判断两个字符串是否绝对相同
printf "$name == J?：" && [ $name = J? ] && echo Y || echo N
printf "$name == J*：" && [ $name = J* ] && echo Y || echo N
name=J*
printf "$name == J*：" && [ $name = J* ] && echo Y || echo N
printf "a == a：" && [[ a == a ]] && echo Y || echo N
printf "a == b：" && [ a == b ] && echo Y || echo N
# [[]] 使用 =~ 进行正则匹配
name="welcome to beijing"
printf "$name =~ w：" && [[ $name =~ w ]] && echo Y || echo N
printf "$name =~ [0-9]：" && [[ $name =~ [0-9] ]] && echo Y || echo N
printf "$name =~ [a-z]：" && [[ $name =~ [a-z] ]] && echo Y || echo N
printf "$name =~ [A-Z]：" && [[ $name =~ [A-Z] ]] && echo Y || echo N
# () 分组，改变运算符优先级
[[ a == a && (b == b || c == d) ]] && echo Y || echo N
[[ a == a && (b == g || c == d) ]] && echo Y || echo N

