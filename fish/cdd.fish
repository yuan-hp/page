#!/usr/bin/env fish
#UFUNCTION=快速进入某些文件夹
#-------路径存储的函数-----------
function cat_cdd_list
printf "\
#-h 显示帮助
#fcfg 进入fish函数配置文件夹 $HOME/.config/fish/functions
#tmp 进入个人tmp文件夹 /cygdrive/f/tmp
#ftir 光谱仪硬件软件 /cygdrive/f/FTIR
"

end

function cdd
    set cmd_name "cdd" #设计的指令名称
	set real_cmd "cd"  #真正执行的指令
	set data_src "cat_cdd_list"  #数据来源
    set cnt (count $argv)
	if test $cnt -gt 0
	    set CMD_IN $argv
	else
        echo "使用 $cmd_name -h 查看帮助！"
        return 
	end
	switch $CMD_IN
    case "-h"
  		echo "Usage: $cmd_name [option]   快速进入一些文件夹"
		echo
		cat_cdd_list | awk '{gsub(/#/, "");print $1,$2}' | column -s \  -t
		echo
		return  
	case "*"
	    set find_id "$data_src | awk '/#$argv/{print \$3}' "
		#echo $find_id
		set find_id (eval $find_id)     
		if test -n "$find_id"
            eval "$real_cmd $find_id"
            pwd
            return 
		end
		echo "使用 $cmd_name -h 查看帮助！"
		return 
	end

end


