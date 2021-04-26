#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: mplot.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：简单通用绘图
#-------------------------------------------------------
#UFUNCTION=简单通用绘图,文件或者管道

plt="/tmp/plotdemo_aaa_bbb.plt" #临时文件
datasrc="/tmp/plotdemo_aaa_bbb.dat" #数据文件
filename=""

cmd="mplot"
dataselect="1"
smooth=false #是否平滑曲线
function main(){
    if [ $# -gt 0 ] ; then 
        while getopts ':d:hs' OPT ;do 
            case $OPT in
                d) dataselect=$OPTARG;;
                s) smooth="true" ;;
                h) err;;
                *) err;;
             esac 
        done 
        shift $((OPTIND-1)) #移除已经解析的参数

        if [ $# -eq 0 ] ; then 
            var="$(</dev/stdin)"
            echo "$var" > $datasrc
            filename=$datasrc
            mplot $filename $dataselect
        else 
            if [ -f $1 ] ; then 
                filename=$1
                mplot $filename $dataselect
            else 
                err
            fi 
        fi 
    else  #管道读取数据并画图
        var="$(</dev/stdin)"
        echo "$var" > $datasrc
        filename=$datasrc
        mplot $datasrc $dataselect
       
    fi 


}

function err() {
    echo " Use : $cmd [-d](1:2) [-s] filename or cat filename | $cmd [-d](1:2) [-s]"
    echo "-d:设置数据源 例如：cat m.dat | $cmd -d 1:2 "
    echo "-s:图线平滑"
    echo "-h:显示帮助"
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


#---------------------------------------
#自动杀死包含特定字符的进程
#@param1：进程名或者进程关键字
#---------------------------------------
function AutoKill(){
    if [ $# -eq 0 ] ; then   
        return 2
    fi

    local src=$(ps -a | grep $1 | awk '{print $1}') 
    for i in $src 
    do 
        #pid=$(echo "$i" | cut -d' ' -f1)
        kill -9 $i  
        local status=$?
        if [ $status -eq 0 ] ; then 
            echo "[log] 发现 '$i' 进程, 已经杀死该进程!"
        else
            echo "[log] 发现 '$i' 进程, 杀死该进程失败!"
            return 2
        fi 
        return 0
    done      
}
#------------------
#
#------------------
function mplot() {
    test ! -f $1 && echo "There is no $1 file!" && exit 2 
    AutoKill gnuplot  #首先关闭已经开启的gnuplot进程
    echo "#!/usr/bin/env gnuplot" > $plt 
    echo "set grid  #设置网格" >> $plt 
    echo "set xlabel \"x\"" >> $plt
    echo "set ylabel \"y\"" >> $plt
    echo "set ylabel \"y\"" >> $plt
    if [[ $smooth == "true" ]] ;then 
        echo "plot \"$(basename $1)\" u $2 smooth bezier t \"\"" >> $plt
    else 
        echo "plot \"$(basename $1)\" u $2 w l t \"\"" >> $plt
    fi 
    #echo "pause -1" >> $plt
    cd $(dirname $plt)
    chmod +x $plt 
    fish -c "open $plt "
}

main $* 