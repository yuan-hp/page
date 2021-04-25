#!/usr/bin/fish
#UFUNCTION=打开gitee(码云)
function github
    if test -z $argv[1]
        open https://github.com/ > /dev/null ^ /dev/null &
    else if test $argv[1] = "-help"
        echo "  该指令将会在默认浏览器中打开github。"
    end
end

