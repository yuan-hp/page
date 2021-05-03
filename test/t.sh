#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: tplot.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：终端条状图
#-------------------------------------------------------
#UFUNCTION=终端条状图

FORMAT=5 #格式化数据位宽

rfile="/tmp/tplot.dat"
function main(){
        # tplot $rfile 
    if [ -f $1 ] ; then 
        if [[ $2 = *":"* ]] ; then 
            c1=$(echo $2 | cut -d':' -f1)
            c2=$(echo $2 | cut -d':' -f2)
            cat $1 | awk '{print $"'$c1'",$"'$c2'"}' > $rfile
            tplot $rfile
        elif [ -z $2 ] ; then 
            tplot $1 
        else 
            mhelp
        fi 
    else 
        mhelp 
    fi 
}


mhelp() {
    echo ""
    echo "  Usage: tplot filename [x:y]"
    echo "  默认1,2列，可使用x:y指定x，y数据的列"
    echo "  例如使用m.dat的2,3列数据为x，y数据:  tplot m.dat 2:3"
    echo ""
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
# 条状图输出
# @param1：x值
# @param2：y值
# @param3：图形实际长度
#-------------------------------------

function mecho() {
    local tp=""
    if [ $# -gt 0 ] ;then 
        for ((i=0;i<$3;i++)) 
        do 
            tp="$tp "
        done 
    fi 
    echo -e "$(printf "%${FORMAT}i" $1)| \e[1;42m$tp\e[0m$2"
}

#-------------------------
# 获取某一列占用的最多字符数
#------------------------
function getMaxLen() {
    test ! -f $1 && echo "no $1 file" && exit 2
    cat $1 | awk 'BEGIN{
            maxlen=0
        }
        {
            if ( $1 ~ /^[-0-9]+$/) {
                maxlen = (length($1) > maxlen) ? length($1) : maxlen
            }
        }
        END {
            print maxlen
        }
        '
}
#显示指定列的数据
function src () {
    COLUMNS=$(stty size|awk '{print $2}') #终端列数
    cat $1 | awk 'BEGIN{
        i=0
        ymax=$2
        ymin=$2
    }
    {
        if ( $2 ~ /^[-0-9.]+$/) {
            if(i==0){
                y[i]=$2
                x[i]=$1
                ymax= $2 
                ymin = $2
                i=i+1
            } else {
                y[i]=$2
                x[i]=$1
                ymax= $2> ymax? $2 : ymax 
                ymin= $2<ymin?$2 : ymin
                i=i+1
            }
        }
    }
    END{
        range=ymax-ymin
        if ( range > "'$COLUMNS'") {
            for (k in y){
                print x[k],y[k],int((y[k]-ymin)*("'$COLUMNS'" -20)/range)+2
            }
        } 
        else 
        {
            for(k in y){
                print x[k],y[k],y[k]-ymin+1
            }
            
        }
        
    }'
}


function tplot() {
    test ! -f $1 && echo "no $1 file" && exit 2
    srcfile=$(date +%Y%m%d%H%M%S.dat)
    src $1> $srcfile
    FORMAT=$(getMaxLen $srcfile)
    while read line 
    do 
        mecho $line
    done < $srcfile

    rm -rf $srcfile
}


main $* 
