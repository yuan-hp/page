#!/usr/bin/env fish
#根据Section和Option读取ini文件
#you can use :
# readini filepath
# readini filepath section
# readini filepath section option

function readini --description 'Read ini file'

    set fid $argv[1]
    test ! -f $fid && echo "不存在文件$fid" && return 2
    if test (count $argv) -eq 3
        set section $argv[2]
        set option $argv[3]
        set src (cat $fid | awk '/\['$section'\]/{f=1;next} /\[*\]/{f=0} f' |  #找出section下的所有内容
        grep $option | # 匹配option的行 
        grep '='     | # 看看是不是存在=
        cut -d'=' -f2| # 获取对应的值
        cut -d'#' -f1| # 去除注释
        cut -d';' -f1| #去除注释
        awk '{gsub(/^\s+|\s+$/, "");print}') #去掉最前面的空格
        echo $src
        test (count $src) -eq 0 && echo "Usage :  ReadIni FilePath [Section] [Option]" && return 2 || return 0  #读取到有效数据 返回状态码0
    else if test (count $argv) -eq 2   #参数解析
        set section $argv[2]
        cat $fid | awk '/\['$section'\]/{f=1;next} /\[*\]/{f=0} f' |grep '=' |cut -d'#' -f1|cut -d';' -f1 | awk '{gsub(/^\s+|\s+$/, "");print}'
        if test (cat $fid | awk '/\['$section'\]/{f=1;next} /\[*\]/{f=0} f' |grep '='| wc -l) -eq 0
            return 2
        else
            return 0
        end 
    else if test (count $argv) -eq 1
        cat $fid | grep '=\|\[*\]' | cut -d'#' -f1|cut -d';' -f1 
    else 
		echo "  Usage : ReadIni FilePath Section Option"
        return 2
    end  
end



