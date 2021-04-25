#!/usr/bin/fish
#UFUNCTION=打开看云
function kancloud 
    if test -z $argv[1]
        open https://www.kancloud.cn/dashboard
    else if test $argv[1] = "-help"
        echo "  该指令将会在默认浏览器中打开gitee。"
    end
end