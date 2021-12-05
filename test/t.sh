#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: gplt
#	Author		： hpy
#	Date		：2021年11月22日
#	Description	： 通用绘图工具--> 简单使用版本
#-------------------------------------------------------


function mhelp() {
    printf " 
Version: gplt 1.0
NOTE:调用gnuplot从文件中按列取数据画图  
Usage: `basename $0` [option] 
    -p [f1,l1,x1,y1:f2,l2,x2,y2;...] 指明作图数据来源和线名称,以及使用哪几列作为x,y,冒号分割数据组,当x<=0时,x取整数递增序列
    -t string                        作图的标题
    -x string                        x轴显示内容 
    -y string                        x轴显示内容 
    -o string                        输出为图片,不支持路径,string仅仅是输出的文件名称     
    -s                               对曲线进行平滑处理
    -h                               帮助
示例:
    `basename $0` -p "m.txt,l1,1,2:m.txt,l1,1,3" -x "t" -y "y" -t "demo" -o test.png
    `basename $0` -p "m.txt,l1,1,2" -s

    <https://gitee.com/yuan_hp/page/tree/master/deepin/$(basename $0)>
\n" 
}


function useGnuplotPlot() {
    local plt="gplt_t.plt" #临时文件
    local b="" 
    local e=""
    local p="" # -p "file,title,1,2:file2,title,1,3" 
    local xlabel="x"
    local ylabel="y"
    local a_title=""
    local out=""
    local s="false"
    test ${#} -eq 0 &&  mhelp && return 2
    # 参数解析 
        while getopts 'p:x:t:y:o:hs' OPT;do
        case $OPT in
            p)
                p="$OPTARG" ; p=${p// /};;  # 画图资源
            t) 
                a_title="$OPTARG" ;;
            x)
                xlabel="$OPTARG" ;;
            y)
                ylabel="$OPTARG" ;;
            o)
                out="$OPTARG" ;; 
            h)   
                mhelp;return 0  ;;
            s)   
                s="true" ;; # 平滑曲线
            ?)
                mhelp
                return 2
                ;;
        esac
    done
    shift $((OPTIND-1)) #移除已经解析的参数
    fid="$*"
    # ----- 
    test ! -f $fid && echo "There is no $1 file!" && return 2
    AutoKill gnuplot  #首先关闭已经开启的gnuplot进程
    echo "#!/usr/bin/env gnuplot" > $plt 
    if [ ! -z $out ] ; then 
        echo "set term pngcairo lw 2" >> $plt
        echo "set output \"$(basename $out)\"" >> $plt
    fi 
    echo "set grid  #设置网格" >> $plt 
    echo "set xlabel \"${xlabel}\"" >> $plt
    echo "set ylabel \"${ylabel}\"" >> $plt
    if [ -z $a_title ] ; then 
        echo 
    else 
        echo "set title \"$a_title\"" >> $plt
    fi 
    if [[ $s == "true" ]] ;then 
        line=(${p//:/ }) 
        line_num=${#line[@]}
        echo "plot\\" >> $plt 
        line_max_1=0
        ((line_max_1=line_num-1))
        for (( i=0;i<line_num;i++))
        do
            t=${line[$i]}
            t=(${t//,/ })
            file_dir=${t[0]}; test -z $file_dir && mhelp && return 2
            title=${t[1]}   ; test -z $title && mhelp return 2
            x=${t[2]} ;       test -z $x && mhelp return 2
            y=${t[3]} ;       test -z $y && mhelp return 2

            if [ $i -eq $line_max_1 ] ; then 
                if [ -z $x ] ; then 
                    echo "    \"$file_dir\" u $y smooth bezier t \"$title\"" >> $plt
                else 
                    echo "    \"$file_dir\" u $x:$y smooth bezier t \"$title\"" >> $plt
                fi
            else
                if [ -z $x ] ; then 
                    echo "    \"$file_dir\" u $y smooth bezier t \"$title\",\\" >> $plt
                else 
                    echo "    \"$file_dir\" u $x:$y smooth bezier t \"$title\",\\" >> $plt
                fi 
            fi 
        done 
    else 
        line=(${p//:/ }) 
        line_num=${#line[@]}
        echo "plot\\" >> $plt 
        line_max_1=0
        ((line_max_1=line_num-1))
        for (( i=0;i<line_num;i++))
        do
            t=${line[$i]}
            t=(${t//,/ })
            file_dir=${t[0]} ;test -z $file_dir && mhelp && return 2
            title=${t[1]}  ;  test -z $title && mhelp return 2
            x=${t[2]} ;       test -z $x && mhelp return 2
            y=${t[3]} ;       test -z $y && mhelp return 2

            if [ $i -eq $line_max_1 ] ; then 
                if [ $x -le 0 ] ; then 
                    echo "    \"$file_dir\" u $y w l t \"$title\"" >> $plt
                else 
                    echo "    \"$file_dir\" u $x:$y w l t \"$title\"" >> $plt
                fi 
            else
                if [ $x -le 0 ] ; then 
                    echo "    \"$file_dir\" u $y w l t \"$title\",\\" >> $plt
                else 
                    echo "    \"$file_dir\" u $x:$y w l t \"$title\",\\" >> $plt
                fi 
            fi 
        done 
    fi 
    if [ ! -z $out ] ; then 
        echo "set output" >> $plt
        echo "set term wxt" >> $plt
        echo "exit" >> $plt
    else 
        echo "pause -1" >> $plt
    fi 
    
    cd $(dirname $plt)
    chmod +x $plt 
    #fish -c "open $plt "
	gnuplot -c $(basename $plt) & 

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

#
useGnuplotPlot $* 
