#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: pkg.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：个人脚本安装
#-------------------------------------------------------
 
url="http://yuan_hp.gitee.io/page"
bin_path="$HOME/bin"
fish_path="$HOME/.config/fish/functions"

function main(){

    #预处理命令
    if [ $# -gt 0 ] ; then 
        cmd=$1
        str=""  #读取除开命令的其他参数
        idx=0
        for i in $*
        do 
            test ! $idx -eq 0 && str="$str $i"
            idx=$((idx+1))
        done 
    fi 

    case $cmd in 
        "install") minstall $str ;;  #安装指定包
        "list") mlist ;;  #列出所有资源包
        "find") mfind $str ;; #资源包模糊查找
        "init") minstall_all;; #安装所有脚本
        "help") mhelp ;; #帮助
    esac 
}
#---------------------------------------
#显示帮助
#---------------------------------------
function mhelp() {
    echo " Install script!"
    echo "pkg install script  安装script"
    echo "pkg mlist           列出所有资源"
    echo "pkg find script     查找资源"
    echo "pkg init            安装所有脚本"
    echo "pkg help            显示帮助"

    echo 
    
}
#--------------------------------------
#安装编写的脚本
#参数为需要安装的脚本
#--------------------------------------
function minstall(){
    local src=$(curl $url/pkg.all) #读取资源包
    local msys=$(sys_check) #检查系统
    test ! -d $fish_path && mkdir $fish_path
    test ! -d $bin_path && mkdir $bin_path
    if [[ "$msys" -eq "cygwin" ]] ; then 
        for i in $*
        do 
            if [[ $(echo $src|grep "cygwin/$i") != ""   ]] ; then 
                if [[ $i == *".fish" ]] ; then 
                    if [ $(exist $i) -eq 0 ] ; then 
                        wget -P $fish_path "$url/cygwin/$i"
                        chmod +x $fish_path/$i
                    fi 
                else
                    if [ $(exist $i) -eq 0 ] ; then 
                        wget -P $bin_path "$url/cygwin/$i"
                        chmod +x $bin_path/$i
                    fi 
                fi 
            elif [[ $(echo $src|grep "deepin/$i") != ""   ]] ; then 
                if [[ $i == *".fish" ]] ; then 
                    if [ $(exist $i) -eq 0 ] ; then 
                        wget -P $fish_path "$url/deepin/$i"
                        chmod +x $fish_path/$i
                    fi 
                else
                    if [ $(exist $i) -eq 0 ] ; then 
                        wget -P $bin_path "$url/deepin/$i"
                        chmod +x $bin_path/$i
                    fi 
                fi 
            else 
                echo "fail: $i setup failed! Can't find package!"
            fi 
        done 
    else  #不是cygwin系统
        if [[ $(echo $src|grep "deepin/$i") != ""   ]] ; then 
            if [[ $i == *".fish" ]] ; then 
                wget -P $fish_path "$url/deepin/$i"
                chmod +x $fish_path/$i
            else
                wget -P $bin_path "$url/deepin/$i"
                chmod +x $bin_path/$i
            fi 
        else 
            echo "fail: $i setup failed! Can't find package!"
        fi       
    fi 
}
#--------------------------------------
#安装编写的脚本
#参数为需要安装的脚本
#--------------------------------------
function minstall_all(){
    local src=$(curl $url/pkg.all) #读取资源包
    local msys=$(sys_check) #检查系统
    test ! -d $fish_path && mkdir $fish_path
    test ! -d $bin_path && mkdir $bin_path
    for i in $src 
    do 
        t=$(basename $i)
        if [[ "$msys" -eq "cygwin" ]] ; then 
            if [[ $i == *".fish" ]] ; then 
                if [ $(exist $t) -eq 0 ] ; then 
                    wget -P $fish_path "$url/$i"
                fi 
            else
                if [ $(exist $t) -eq 0 ] ; then 
                    wget -P $bin_path "$url/$i"
                fi 
            fi 
        else 
            if [[ $i == deepin/*".fish" ]] ; then 
                if [ $(exist $t) -eq 0 ] ; then 
                    wget -P $fish_path "$url/$i"
                fi 
            elif [[ $i == deepin/* ]] ; then 
                if [ $(exist $t) -eq 0 ] ; then 
                    wget -P $bin_path "$url/$i"
                fi 
            fi 
        fi 
    done 
    chmod +x $fish_path/*
    chmod +x $bin_path/*
}
#--------------------------
#系统
#--------------------------
function sys_check(){
    case $(uname -s | tr [A-Z] [a-z]) in 
        *cygwin*) echo "cygwin" ;;
        *linux*) echo "linux" ;;
    esac 
}

#--------------------------
#检测是否已经安装
#--------------------------
function exist(){
    if  [[ $1 == *".fish" ]] ; then
       if [ -f $fish_path/$1 ] ; then 
            read -p "You had install $1! Dou you want to re install $1? y/n :" ans 
            if [[ $ans == "y" ]] ; then 
                rm $fish_path/$1
                echo 0
                return 0
            else 
                echo 2
                return 0
            fi 
       fi 
    else 
        if [ -f $bin_path/$1 ] ; then 
            read -p "You had install $1! Dou you want to re install $1? y/n :" ans 
            if [[ $ans == "y" ]] ; then 
                $fish_path/$1
                echo 0
                return 0
            else 
                echo 2
                return 0
            fi 
        fi 
    fi 
    echo 0
}

#--------------------------
#列出所有资源包
#--------------------------
function mlist() {
    local src=$(curl $url/pkg.all) #读取资源包
    local idx=0
    for i in $src 
    do 
        echo " $idx: $i"
        idx=$((idx+1))
    done 
}

#--------------------------
#列出所有资源包
#--------------------------
function mfind() {
    local src=$(curl $url/pkg.all) #读取资源包
    echo 
    for i in $*
    do 
        echo "------------- $i -----------"
        echo $src | tr [' '] ['\n']| grep $i
    done 
}



main $*