#!/bin/bash
<<'EOF'
parted 可以用于创建磁盘分区
parted [选项] [磁盘 [操作指令]]
操作指令                                 功能描述
help                                    查看帮助
mklabel<LABEL-TYPE>                     新建分区表
mkpart PART-TYPE [FS-TYPE] START END    新建分区
rm NUMBER                               删除分区

创建分区使用mkpart指令
parted 磁盘 mkpart 分区类型 [文件系统类型] 开始 结束
分区类型 primary、logical、extended 
文件系统类型 fat16、fat32、ext2、ext3、linux-swap
开始结束的位置默认单位为MB，也可以使用百分比表示

parted 还可以进行分区检查、调整分区大小、恢复误删除分区等操作
EOF

# 修改分区表类型
parted /dev/sdc mklabel gpt -s # 新建GPT分区表格式 用 -s 选项禁止交互的警告提示信息
parted /dev/sdc mklabel gpt # 修改分区表格式
parted /dev/sdc print # 查看磁盘分区信息 

# 创建与删除分区
parted /dev/sdc mkpart primary xfs 1 1G # 创建xfs格式的主分区，从磁盘的第1MB位置开始，到1GB的位置结束
parted /dev/sdc mkpart primary xf2 1G 2G # 创建1G大小的分区
parted /dev/sdc mkpart primary 2G 50%
parted /dev/sdc mkpart primary 50% 100%
parted /dev/sdc print
parted /dev/sdc rm 4 # 删除任意分区

