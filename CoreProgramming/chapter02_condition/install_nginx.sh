#!/bin/bash
<<'EOF'
因为RPM等类似的二进制软件往往不能提供最新的版本，
并且不具备自定义安装选项，
所以生产环境中经常需要采用源码的方式安装软件。
但采用源码的方式安装软件的步骤又比较烦琐，
所以编写脚本实现自动化安装软件是非常重要的。

使用脚本编程，一次编写，多次复用，文本编写方便修改维护。    
EOF

# 功能描述(Description)：一键源码安装Nginx安装包

# 定义不同的颜色属性
setcolor_failure="echo -ne \\e[91m"
setcolor_success="echo -ne \\e[32m"
setcolor_normal="echo -ne \\e[0m"

# 判断是否以管理员身份执行脚本
if [[ $UID -ne 0 ]]; then
    $setcolor_failure
    echo -n "请以管理员身份运行该脚本."
    $setcolor_normal
fi

# 判断系统中是否存在 wget 下载工具
# wget 使用 -c 选项可以开启断点续传功能

if dpkg -s wget &> /dev/null; then
    if [[ ! -f nginx-1.19.1.tar.gz ]]; then
        wget -c http://nginx.org/download/nginx-1.19.1.tar.gz
    fi
else
    $setcolor_failure
    echo -n "未找到wget，请先安装该软件"
    $setcolor_normal
    exit
fi

# 如果没有nginx账户，则脚本自动创建该账户
if ! id nginx &> dev/null; then
    sudo adduser -s /sbin/nologin nginx
fi

# 测试是否存在正确的源码包软件
# 在源码编译安装前，先安装相关依赖包
# gcc: C语言编译器，pcre-devel: Perl兼容的正则表达式库
# zlib-devel: gzip 压缩库，openssl-devel: Openssl加密库
if [[ ! -f nginx-1.19.1.tar.gz ]]; then
    $setcolor_failure
    echo -n "未找到nginx源码包，请先正确下载该软件."
    $setcolor_normal
    exit
else
    apt -y install gcc pcre-devel zlib-devel openssl-devel
    clear
    $setcolor_success
    echo -n "接下来需要花几分钟时间编译源码安装nginx..."
    $setcolor_normal
    sleep 6
    tar -xf nginx-1.19.1.tar.gz
    # 编译源码安装nginx，指定账户和组，指定安装路径，开启需要的模块，禁用不需要的模块
    cd nginx-1.19.1/
    ./configure \
        --user=nginx \
        --group=nginx \
        --prefix=/data/server/nginx \
        --with-stream \
        --with-http_ssl_module \
        --with-http_stub_status_module \
        --without-http_autoindex_module \
        --without-http_ssi_module 
    make
    make install
fi

if [[ -x /data/server/nginx/sbin/nginx ]]; then
    clear
    $setcolor_success
    echo -n "一键部署nginx已经完成!"
    $setcolor_normal
fi