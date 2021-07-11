#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: hp
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：常用命令记录，自用
#-------------------------------------------------------
#UFUNCTION=一些常用工具的常用指令

root="./dir"

main(){
    echo $* 
    if [ -d $root ] ; then 
        if [[ $1 == "add" ]] ; then # 添加内容
            fish -c "open $root > /dev/null ^ /dev/null &"
        elif [[ $1 == "push" ]] ; then  # 同步修改后的数据
            cd ..
            ./upCloud
            echo hhhh
        else 
            cd $root
            dis
        fi 
    else 
        echo "不存在路径$root "
    fi  
}

function dis() {
    PS3="按提示输入序号："
    select i in $(ls) quit 
    do 
        if [[ $i == "quit" ]] ; then 
            exit 0 
        elif [ -d $i ] ; then 
            clear  
            cd $i
            dis 
        elif [ -f $i ] ; then 
            echo 
            echo " >>> $i <<<"
            cat $i
            echo 
            exit 0 
        fi 
    done 

}





#-------------------------------------
main $* 