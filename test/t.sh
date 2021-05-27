#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: .sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：简单通用绘图
#-------------------------------------------------------
#UFUNCTION=一些常用工具的常用指令

function main() {
    case $1 in 
        git) mgit ;; 
        df) mdf ;; 
        *) mhelp ;;
    esac 
}


function mhelp() {
cat<<EOF
    How to use !
    Usage: $(basename $0) [string]

    help        帮助
    git         显示git常用命令
    df          磁盘工具命令示例
EOF
}


function mdf() {
cat<<EOF
    Example:
    1.df -hl: 查看磁盘剩余空间
    2.df -h ：查看每个根路径的分区大小
EOF
}

function mgit() {
cat<<EOF
    Example:
    1. git config --global user.name "yhp"
    2. git config --global user.email "yuan_hp@qq.com"
    3. git init
    4. git status
    5. git add <filename> or git add .
    6. git commit -m "note"
    7. git remote add origin https://github.com/yuan-hp/Electron-learn.git
    8. git push -u origin master
    9. git push origin master
    10.git pull origin master
    11.git config --global core.autocrlf false -> CRLF LF 
EOF
}






#-------------------------------------
main $* 