#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: git_config.sh
#	Author		：hpy
#	Date		：2023年11月25日
#	Description	：
#-------------------------------------------------------

email="yuan_hp@qq.com"

ssh-keygen -t rsa -C "$email"


git config --global user.name "$(whoami)"
git config --global user.email "$email"

   