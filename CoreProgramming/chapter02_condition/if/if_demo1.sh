#!/bin/bash

# 读取用户输入的用户名和密码后，判断是否为空，非空则创建账户并设置密码，否则直接结束。

<<'EOF'
# version: 0.1 (版本 0.1)
read -p "请输入用户名：" user
read -s -p "请输入密码：" pass

if [ ! -z "$user" ]; then
    sudo useradd "$user"
    echo "新建用户 $user 成功"
fi

if [ ! -z "$pass" ]; then
    echo "$user:$pass" | sudo chpasswd
    echo "重置用户 $user 密码成功"
fi
EOF

<<'EOF'
# version: 0.2 (版本 0.2)

read -p "请输入用户名：" user
read -s -p "请输入密码：" pass
if [ ! -z "$user" ]; then
    if [ ! -z "$pass" ]; then
        useradd "$user"
        echo "$user:$pass" | sudo chpasswd
    fi
fi
EOF

<<'EOF'
# version: 0.3 (版本 0.3)

read -p "请输入用户名：" user
read -s -p "请输入密码：" pass
if [[ ! -z "$user" && ! -z "$pass" ]]; then
    useradd "$user"
    echo "$user:$pass" | sudo chpasswd
fi
EOF

<<'EOF'
# version: 0.4 (版本 0.4)

read -p "请输入用户名：" user
read -s -p "请输入密码：" pass
if [ ! -z "$user" -a ! -z "$pass" ]; then
    useradd "$user"
    echo "$user:$pass" | sudo chpasswd
fi
EOF

<<'EOF'
# version: 0.5 (版本 0.5)
EOF
read -p "请输入用户名：" user
read -s -p "请输入密码：" pass
if [ ! -z "$user" ] && [ ! -z "$pass" ]; then
    useradd "$user"
    echo "$user:$pass" | sudo chpasswd
fi