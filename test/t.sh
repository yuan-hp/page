#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: gtp
#	Author		：hpy
#	Date		：2021年11月20日
#	Description	： 根据标记获取标记间的内容
#-------------------------------------------------------


function mhelp() {
    printf "    
Usage: `basename $0` [option] filename 
Usage: cat filename | `basename $0` [option] 
    -b sring         设置识别的起始标记为 string
    -e string        设置识别的结束标记为 string
    -m [awk|sed]     设置提取内容的工具，sed模式和awk模式,默认sed模式,sed模式会包含标记,而awk模式则不包含
    -h               帮助
示例:
    cat filename | `basename $0` -b "MARK1" -e "MARK2" -m awk
    `basename $0` -b "MARK1" -e "MARK2" filename

    <https://gitee.com/yuan_hp/page/tree/master/deepin/$(basename $0)>
\n" 
}


function getContextWithMark() {
    local b="" 
    local e=""
    local fid="" 
    # 参数解析 
        while getopts 'b:e:m:h' OPT;do
        case $OPT in
            b)
                b="$OPTARG" ;;  # 开始标记
            e)
                e="$OPTARG" ;;  # 结束标记
            m)
                m="$OPTARG" ;;  # 模式
            h)   mhelp;return 0  ;;
            ?)
                mhelp
                return 2
                ;;
        esac
    done
    shift $((OPTIND-1)) #移除已经解析的参数
    fid="$*"
    # 方法1:该方式会保留标记 
    if [ -z $m ] || [[ $m == "sed" ]] ; then  
        test -z $b && mhelp && return 0
        sed -n "/$b/,/$e/p" $fid 
        return 0
    fi

    # 方法2:该方式不会显示标记行,注意采用awk模式时空格为分隔符
    if [[ $m == "awk" ]] ; then 
        cat $fid | awk '/'"$b"'/{m=1;next} /'"$e"'/{exit} m{print}'
    fi 
}


#
getContextWithMark $* 