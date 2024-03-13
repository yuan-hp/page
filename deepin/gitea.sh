#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: gitea.sh
#	Author		：hpy
#	Date		：2024年03月06日
#	Description	：
#-------------------------------------------------------

# 目标项目地址
if [ -f .giteamark ] ; then 
    url=$(cat .giteamark)
else 
    url=https://gitee.com/openyhp/termux-gitea/raw/master
fi

# 显示帮助
if [[ "$1" == "-h" ]] || [[ "$1" == "help" ]] || [[ "$1" == "--help" ]] ; then     
printf "
动态IP的Gitea仓库工具
Usage:$(basename $0) cmd
    $(basename $0)             打开个人服务器Gitea网址
    $(basename $0)   mark      标记当前git仓库远程为个人服务器的Gitea
    $(basename $0)   push      推送当前仓库到远程
    $(basename $0)   push str  推送当前仓库到远程,设置commit为str

    兼容其他git的命令
"
    exit 
fi 




# 获取gitea 个人服务器的网址
git_server="https://$(curl -s $url/gitea.port|cut -d: -f1)"
test $? -ne 0 && echo "can not get git_server addr" && exit 1
echo "git_server:$git_server"


test #{#git_server} -le 3 && echo "failed get server" && exit 1


# 如果当前文件夹存在 .git 文件夹，则修正远程地址
# .giteamark 文件存在则表明当前仓库是 自己在动态IP上基于gitea的仓库
if [ -d .git ] && [ -f .giteamark ] ; then
    echo "当前仓库被标记为基于动态IP的gitea服务器"
    oldurl=$(cat .git/config | grep url | awk '{print $3}')
    gitname=$(basename $(dirname $oldurl))/$(basename $oldurl)
    git remote set-url origin "$git_server/$gitname"

    if [ -f .git/config ] ; then 
        sed -i 's#//#//yhp:yhp123456@#' .git/config 
    fi 
fi 

if [ $# -eq 0 ]; then 
    fish -c "open $git_server"
    exit 
fi 


# 克隆动态地址的仓库
if [[ "$1" == "clone" ]]  ; then     
    oldurl=$2
    gitname=$(basename $(dirname $oldurl))/$(basename $oldurl)
    git clone "$git_server/$gitname"
    exit 
fi 

# 标记当前仓库为 基于 动态IP 的gitea 
if [[ "$1" == "mark" ]] && [ -d .git ]  && [ $# -eq 1 ]; then 
    test ! -f .giteamark && echo "$url" > .giteamark 
    exit 
fi 


# 推送仓库到远端服务器
if [[ "$1" == "push" ]] && [ -d .git ] && [ ${#git_server} -gt 3 ] ; then   

    git status
    git add .
    if [[ $# -eq 1 ]];then
        dat=$(date +%Y/%m/%d\ %H:%M:%S)
    else
        dat=$2
    fi
    git commit -m "$dat"
    git push 
    exit 
fi 




git $* 

