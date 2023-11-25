#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: git_config.sh
#	Author		：hpy
#	Date		：2023年11月25日
#	Description	：为本机生成公钥
#-------------------------------------------------------

email="yuan_hp@qq.com"

ssh-keygen -t rsa -C "$email"


git config --global user.name "$(whoami)"
git config --global user.email "$email"

git config --global core.autocrlf false # 不自动转换LF为 CRLF

# 配置下次提交时记住密码,明文存储,永不过期(不安全)
# git config --global credential.helper store 

# 密码缓存在内存,2小时
git config --global credential.helper cache --timeout7200
echo "---------------"
cat ~/.ssh/id_rsa.pub