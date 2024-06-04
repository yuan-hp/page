#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: gitea.sh
#	Author		：hpy
#	Date		：2024年03月06日
#	Description	：
#-------------------------------------------------------

# 目标项目地址
url=https://gitee.com/openyhp/termux-gitea/raw/master

# 获取gitea 个人服务器的网址
git_server=$(curl -s $url/net.txt)
test $? -ne 0 && echo "can not get git_server addr" && exit 1
echo "git_server:$git_server"

# 如果当前文件夹存在 .git 文件夹，则修正远程地址
if [ -d .git ] ; then 
    
fi 




# function main(){
    
#     case $1
#         clone:

#     esac 

#     exit 

# }