#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: hp
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：常用命令记录，自用
#-------------------------------------------------------
#UFUNCTION=一些常用工具的常用指令

function main() {
    case $1 in 
        git) mgit ;; 
        df) mdf ;; 
        free) mfree ;; 
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
    free        显示内存状态
EOF
}

function mfree() {
cat<<EOF
    Example:
    1.free -m    :以MB为单位显示内存使用情况
    2.free -k    :以KB为单位显示内存使用情况
    3.free -h    :以合适的单位显示内存使用情况，最大为三位数，自动计算对应的单位值
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