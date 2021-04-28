#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: math.dft.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：离散傅里叶变化
#-------------------------------------------------------
#UFUNCTION=求文件第1列数据的离散傅里叶变换
function main(){
    findIpUser
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

#-------------------------------------

#-------------------------------------
function findIpUser() {
     a=1　
    while :
    do 　　　
        echo $(ping -c 1 192.168.0.$a | grep "ttl" | awk '{print $4}'| sed 's/://g')　　
        ip=$(ping -c 1 192.168.0.$a | grep "ttl" | awk '{print $4}'| sed 's/://g')　
        a=$[$a+1]
        echo $ip >> ip.txt
    done 
}


main $* 