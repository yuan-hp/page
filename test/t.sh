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
#实现离散傅里叶变换
#参数1是数据文件，每行一个数据
#参数2是采样频率，默认为1
#-------------------------------------
function dft() {
    local fs=1
    if [ $# -eq 2 ] ; then 
        if [ $(IsNumber $2) -eq 0 ] ; then 
            fs=$2
        fi 
    fi 

    cat $1 | awk 'BEGIN{
            PI=3.1415926
            e=2.718281828459
            N=0
        }
        {
            if( $1 ~ /^[-0-9.]/) {
                x[N] = $1
                N=N+1
            }
        }

        END{
            for ( k =0;k<=N/2;k=k+1){
                re[k] = 0
                im[k] = 0
                for( i =0;i<N ; i++){
                    re[k] = re[k] + x[i]*cos(2*PI*k*i/N)
                    im[k] = im[k] - x[i]*sin(2*PI*k*i/N)
                }
                a =sqrt( re[k]^2 + im[k]^2 ) /N*2
                #幅度谱
                print k*"'$fs'",a

            }
        }'
}


#-------------------------------------
#使用awk脚本合并类似行
#@oaram1 : 将要操作的文件对象
#-------------------------------------
function hb() {

    cat $1 | awk '
        BEGIN {
            FS=" "  #指定输入文件的分隔符
            OFS=" " #指定输出文件的分隔符 
            id=1    #主键ID的列 ,可设置第几列为主键 
            cur_d="," #合并数据前后的连接符
        }
    '
}

main $* 