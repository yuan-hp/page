#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: math.dftp.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：离散傅里叶变化
#-------------------------------------------------------
#UFUNCTION=求文件第n列数据的离散傅里叶变换

fs=1  #采样率
cc=1   #列
function main(){
    
    while getopts ":f:c:" opt 
    do
        case $opt in
            f)
                if [ $(IsNumber $OPTARG) -eq 0 ] ; then 
                    fs=$OPTARG
                else 
                    echo "Use:  math.dft [-f]() [-c]() filename " ; exit 2
                fi 
            ;;
            c)
                if [ $(IsNumber $OPTARG) -eq 0 ] ; then 
                    cc=$OPTARG
                else 
                    echo "Use:  math.dft [-f]() [-c]() filename " ; exit 2
                fi 
            ;;
            ?)
                echo "Use:  math.dft [-f]() [-c]() filename " ; exit 2
             ;;
        esac
    done 
    shift $((OPTIND-1)) #移除已经解析的参数
    if [ $# -eq 1 ] ; then 
        test -f $1 && dft $1 || echo "Use:  math.dft [-f]() [-c]() filename " 
    else
         echo "Use:  math.dft [-f]() [-c]() filename "
    fi 
    exit 
    
    
    

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

    cat $1 | awk 'BEGIN{
            PI=3.1415926
            e=2.718281828459
            N=0
        }
        {
            if( $"'$cc'"~ /^[-0-9.]/) {
                x[N] = $"'$cc'"
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


main $* 