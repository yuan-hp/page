#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: math.c.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：复合计算器
#-------------------------------------------------------
#UFUNCTION=复合计算器

scale=10  #精度
cmd="math.c"
function main(){

    if [ $1 == "-h" ] ; then 
        err
    fi 
    mall $*

}

function err() {
    echo " Use : $cmd data [scale]"
    echo 
    exit 2
}
#------------------------------
#判断字符串是否为数字
#@return   0：是  1：不是
#------------------------------
function IsNumber() {
    local y=$(echo "$1" | sed 's/[0-9]//g')
    if [ -z "$y" ];then
        echo 0 #是数字
    else
        echo 1 #"不是数字"
    fi
}

#------------------
#cos
#------------------
function mall(){
    echo "scale=$scale;($*)" | bc -l
}

main $* 