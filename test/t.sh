#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: math.dft.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：离散傅里叶变化
#-------------------------------------------------------
#UFUNCTION=求文件第1列数据的离散傅里叶变换
function main(){
    case $1 in 
        -h) echo "Use:  math.dft filename [fs]" ;;
        *) 
            if [ $# -eq 1 ] ; then 
                test -f $1 && dft $1    ||  echo "Use:  math.dft filename [fs]" 
            elif [ $# -eq 2 ] ; then 
                test -f $1 && dft $1 $2 ||  echo "Use:  math.dft filename [fs]" 
            else
                echo "Use:  math.dft filename [fs]" 
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

#-------------------------------------
function mfit() {
    cat $1 | awk 'BEGIN{
            mean_x = 0
            mean_y = 0 
            len = 0
            idx = 0
        }

        {
            if ( $1 ~ /^[-0-9.]/) {
                x[idx] = $1
                y[idx] = $2
                mean_x = mean_x + $1 
                mean_y = mean_y + $2
                idx = idx +1
            }
        }

        END{
            len = idx 
            #求平均值
            mean_x = mean_x/len 
            mean_y = mean_y/len 
            num1 = 0
            num2 = 0
            for (i=0;i<len;i=i+1){
                num1 = num1 + (x[i] - mean_x) * (y[i] - mean_y)
                num2 = num2 + (x[i] - mean_x) * (x[i] - mean_x)
            }
            b = num1/num2 
            a = mean_y - b*mean_x 
            print "y=",b,"*x+",a

        }'
}


main $* 