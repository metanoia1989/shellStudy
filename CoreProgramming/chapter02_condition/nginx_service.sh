#!/bin/bash
# 简单的sysvinit服务脚本示例 https://github.com/wyhasany/sysvinit-service-generator
### BEGIN INIT INFO
# Provides:          Adam Smith
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       Nginx服务启动脚本
### END INIT INFO

SCRIPT=/data/server/nginx/sbin/nginx
RUNAS=metanoia1989

PIDFILE=/data/server/nginx/logs/nginx.pid
LOGFILE=/data/server/nginx/logs/nginx.log

case $1 in 
start)
    if [ -f $PIDFILE ]; then
        echo -e "\e[91mNginx is already running...\e[0m"
        exit
    else
        $SCRIPT && echo -e "\e[91mNginx is already running...\e[0m"
    fi;;
stop)
    if [ ! -f $PIDFILE ]; then
        echo -e "\e[91mNginx is already stoped.\e[0m"
        exit
    else
        $SCRIPT -s stop && echo -e "\e[91mNginx is already stoped.\e[0m"
    fi;;
restart)
    if [ ! -f $PIDFILE ]; then
        echo -e "\e[91mNginx is already stoped.\e[0m"
        echo -e "\e[91mPlease to run Nginx first.\e[0m"
        exit
    else
        $SCRIPT -s stop && echo -e "\e[91mNginx is stoped.\e[0m"
    fi
    $SCRIPT && echo -e "\e[91mNginx is already running...\e[0m"
    ;;
status)
    if [ -f $PIDFILE ]; then
        echo -e "\e[91mNginx is running...\e[0m"
    else
        echo -e "\e[91mNginx is stoped.\e[0m"
    fi;;
reload)
    if [ ! -f $PIDFILE ]; then
        echo -e "\e[91mNginx is already stoped.\e[0m"
        exit
    else
        $SCRIPT -s reload && echo -e "\e[91mReload configure done.\e[0m"
    fi;;
*)
    echo "Usage: $0 (start|stop|restart|status|reload)";;
esac