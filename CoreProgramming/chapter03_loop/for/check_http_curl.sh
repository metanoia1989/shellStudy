#!/bin/bash
# 功能描述：使用cURL访问具体的HTTP页面，检测HTTP状态码
# 连续测试3次都失败则发送邮件报警

# cUR命令选项说明
# -m 设置超时时间
# -s 设置静默连接
# -o 下载数据另存为
# -w 返回附加信息，HTTP 状态码

url=http://192.168.0.104/index.html
date=$(date +"%Y-%m-%d %H:%M:%S")
mail_to="metanoia1989@localhost"
mail_subject="http_warning"
fail_times=0

for i in 1 2 3
do
    status_code=$(curl -m 3 -s -o /dev/null -w %{http_code} $url)
    if [ $status_code -ne 200 ]; then
        let fail_times++
    fi
    sleep 1
done

if [ $fail_times -eq 3 ]; then
    mail -s $mail_subject $mail_to <<-EOF
检测时间为：$date
$url 页面异常，服务器返回状态码：${status_code}
请尽快排查异常
EOF
else
    cat >> /tmp/http_check.log <<- EOF
$date "$url 页面访问正常"
EOF
fi