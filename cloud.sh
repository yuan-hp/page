#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: cloud.sh
#	Author		：hpy
#	Date		：2024年01月29日
#	Description	：
#-------------------------------------------------------

#-------------------------------------------------------
# 解析ini文件 
#-------------------------------------------------------
function getIni() {
    local b="" 
    local e=""
    local fid="" 
    # 参数解析 
        while getopts 'b:e:mh' OPT;do
        case $OPT in
            b)
                b="$OPTARG" ;;  # 开始标记
            e)
                e="$OPTARG" ;;  # 结束标记
            m)
                m="awk" ;;  # 模式
            h)   mhelp;return 0  ;;
            ?)
                mhelp
                return 2
                ;;
        esac
    done
    shift $((OPTIND-1)) #移除已经解析的参数
    fid="$*"

    # 开始解析
    sed 's/ //g' $fid | awk -F"[=#]" '{
        if( $0 ~ /^#.*/ ) next 
        
        if ($1 ~ /\[.*\]/) {
            buf=$1
            gsub(/\[/,"",buf)
            gsub(/\]/,"",buf)
            m=buf
            next
        }
        if( $0 !~ /.*=.*/ ) next  
        print m"."$1"="$2
        # print $2
    }'

}

ini=$(getIni config.ini)
echo $ini 
ini=($ini)

# echo ${ini[ff]}

# echo ${ini[@]}
