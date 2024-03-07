#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: book.sh
#	Author		：hpy
#	Date		：2024年03月06日
#	Description	：打开个人笔记的网页
#-------------------------------------------------------

url=https://gitee.com/openyhp/termux-gitea/raw/master

bookurl=$(curl $url/book.url)
test $? -eq 0 && fish -c "open $bookurl" || echo "获取链接出错"



