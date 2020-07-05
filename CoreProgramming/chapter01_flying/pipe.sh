#!/bin/bash

# 管道的使用示例

who | wc -l # 统计账号登录数量
ss -nutlp | grep sshd # 查看所有服务监听的端口列表，并且过滤sshd服务
