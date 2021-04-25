#!/usr/bin/env fish
#UFUNCTION=命令直接打开指定web页面
#-------路径存储的函数-----------
function cat_web_list
printf "\
#-h 显示帮助
#blbl 打开哔哩哔哩 https://www.bilibili.com/
#github 打开个人github页面 https://github.com/yuan-hp
#gitee 打开gitee个人主页 https://gitee.com/
#kancloud 打开看云文档 https://www.kancloud.cn/dashboard
#pon 打开ProcessOn在线作图页面 https://www.processon.com/diagrams
#idata 打开iData文献搜索页面 https://www.cn-ki.net/
#zh 打开知乎 https://www.zhihu.com/
#offer 打开投递简历网址 https://www.wondercv.com/campus_recruiting/user_show###
#js 打开金山文档 'https://www.kdocs.cn/latest?from=docs'
#wp 比特球网盘 https://pan.bitqiu.com/index#index/index/type:3/page:1/pid:594e0471e9e94786b864eeabfd7242c5/sort:updateTime/desc:1/view:list/cType:
"

end

function web
    set cmd_name "web" #设计的指令名称
	set real_cmd "open"  #真正执行的指令
	set data_src "cat_web_list"  #数据来源
    set cnt (count $argv)
	if test $cnt -gt 0
	    set CMD_IN $argv
	else
        echo "使用 $cmd_name -h 查看帮助！"
        return 
	end
	switch $CMD_IN
    case "-h"
  		echo "Usage: $cmd_name [option]   快速打开一些网页"
		echo
		cat_web_list | awk '{gsub(/#/, "");print $1,$2}' | column -s \  -t
		echo
		return  
	case "*"
	    set find_id "$data_src | awk '/#$argv/{print \$3}' "
		#echo $find_id
		set find_id (eval $find_id)     
		if test -n "$find_id"
            eval "$real_cmd $find_id"
            return 
		end
		echo "使用 $cmd_name -h 查看帮助！"
		return 
	end

end


