#!/usr/bin/fish
#UFUNCTION=打开gitee(码云)
function gitee
    if test -z $argv[1]
        open https://gitee.com/
    else if test $argv[1] = "-help"
        echo "  该指令将会在默认浏览器中打开gitee。"
    end
end