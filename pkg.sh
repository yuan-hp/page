#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: pkg.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：
#-------------------------------------------------------
 
url="http://yuan_hp.gitee.io/page"
function main(){
    if [ $# -gt 0 ] ; then 
        cmd=$1
        str=""  #读取除开命令的其他参数
        idx=0
        for i in $*
        do 
            test ! $idx -eq 0 && str="$str $i"
            idx=$((idx+1))
        done 
    fi 
    echo $str 
    exit 
    case $cmd in 
        "install") minstall $str ;
    esac 
}

#--------------------------------------
#安装编写的脚本
#--------------------------------------
function minstall(){
    local src=$(curl $url/pkg_list.txt)
    echo $src 
    # for i in $*
    # do 

    # done 
}

main $*