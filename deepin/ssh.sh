#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: book.sh
#	Author		：hpy
#	Date		：2024年03月06日
#	Description	：连接 termux 基于内网云的 ssh 
#-------------------------------------------------------

url=https://gitee.com/openyhp/termux-gitea/raw/master

port=$(curl $url/ssh.port|cut -d: -f2)
echo "ssh -p $port u0_a108@sh3.neiwangyun.net"
eval "ssh -p $port u0_a108@sh3.neiwangyun.net"



