#!/usr/bin/fish
#UFUNCTION=将当前路径直接在配置文件中加入环境变量
function topath
    set p (pwd)
    #set p "/usr/bin"
    echo "当前路径 $p" 
    set q (echo $PATH | xargs -n1 |  grep -w $p | wc -l)
    if test $q -eq 0 
        set dst "$HOME/.config/fish/config.fish" 
        if test ! -f $dst
            if test ! -d (dirname $dst)
                mkdir -p (dirname $dst)
            end 
            touch $dst 
        end 
        echo "set -x PATH \$PATH $p  #add by topath function" >> $dst  #$HOME/.config/fish/config.fish 
        echo "已添加 $p 到fish shell的环境变量，配置文件为 $HOME/.config/fish/config.fish"
    else
        echo "当前路径已经在环境变量中"
    end 
end

#topath 