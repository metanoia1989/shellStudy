#!/bin/bash

<<'EOF'
当网页的数据内容被人恶意篡改后，虽然网页依然可以被访问，但服务器的健康状态已经出问题了！
此时，可以使用Hash值对数据的完整性进行校验，以防止数据被篡改。
数据Hash值的特点就是当数据发生改变时Hash值也会随之改变，如果数据没变化，则Hash值永远不变。
在 CentoS系统中提供了md5sum、 shalsum、sha256sum、sha384sum、sha512sum等可以计算Hash值的命令。

Hash值仅跟内容有关，只要数据不一样，Hash值就不一样。Hash值跟文件名、权限等其他因素也没有关联。  
EOF

echo "hello" | md5sum
echo "hello" | md5sum
echo "hell" | md5sum
echo "hello" > text.txt
md5sum text.txt
mv text.txt hello.txt
md5sum hello.txt

#功能描述(Description): 根据数据的Hash值监控网站数据是否被篡改

url="http://192.168.0.104/index.html"
date=$(date +"%Y-%m-%d %H:%M:%S")

source_hash="b1946ac92492d2347c6235b4d2611184"
url_hash=$(curl -s $url | md5sum | cut -d' ' -f1)
if [ "$url_hash"  != "$source_hash" ];then
    mail -s http_Warning metanoia1989@localhost <<- EOF
    检测时间为：$date
    数据完整性校验失败，$url 页面数据被篡改
    请尽快排查异常
EOF
else
    cat >> /tmp/http_check.log <<- EOF
    $date "$url，数据完整性校验正常"
EOF
fi