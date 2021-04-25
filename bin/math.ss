#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: math.ss.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：求文件第n列的所有数据的方差，制表符或者空格
#                   分割数据
#-------------------------------------------------------
#UFUNCTION=求文件第n列数据的方差
function main(){
    case $1 in 
        -h) echo "Use: math.ss filename [column]" ;;
        *) 
            if [ $# -eq 1 ] ; then 
                test -f $1 && mss $1  ||  echo "Use: math.ss filename [column]" 
            elif [ $# -eq 2 ] ; then 
                test -f $1 && mss $1 $2 ||  echo "Use: math.ss filename [column]"
            else
                echo "Use: math.ss filename [column]" 
            fi  ;;
    esac 

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
#
#-------------------------------------
function mss() {
    local c=1
    if [ $# -eq 2 ] ; then 
        if [ $(IsNumber $2) -eq 0 ] ; then 
            c=$2
        fi 
    fi 

    cat $1|tr '\r' ' ' | awk 'BEGIN{
            idx = 0
            ave = 0
            ss = 0
        }

        {
            if( $"'$c'" ~ /^[-0-9.]/) { 
                x[idx] = $"'$c'"
                idx = idx + 1
                ave = ave + $"'$c'"
            }
        }
        
        END{
            ave = ave / (idx) #平均值
            for (i in x){
                ss += (x[i]-ave)^2
            }
            print ss/idx
        }'
}


main $* 