#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: push.sh
#	Author		：hpy
#	Date		：2024年03月25日
#	Description	：git 规范化推送 
#   https://zhuanlan.zhihu.com/p/182553920
#-------------------------------------------------------

# 仓库平台前缀
GITEE_HEAD="https://yuan_hp:5bb75321ff4fef60ff9e7ab47692b697@gitee.com/yuan_hp"
GITEA_HEAD="http://yhp:c367aca0a07d0779f62208d8bfe24f4d1fe8a9c8@120.46.47.28:3000/yhp"
GITHUB_HEAD="http://yhp:c367aca0a07d0779f62208d8bfe24f4d1fe8a9c8@120.46.47.28:3000/yhp"

ROOTDIR=$(pwd)
# 仓库名称
GIT_NAME="$(basename $ROOTDIR).git"

GIT_PLAT=".pushconf"

function init-config() {
    test -f $GIT_PLAT  && return 
    fg 
    PS3="配置你要推送的平台:"
    choices=( 'exit' 'gitee' 'gitea' 'github') # sample choices
    select dummy in "${choices[@]}"; do  # present numbered choices to user
        IFS=', ' read -ra selChoices <<<"$REPLY"
        # Loop over all numbers entered.
        for choice in "${selChoices[@]}"; do
            # Validate the number entered.
            (( choice >= 1 && choice <= ${#choices[@]} )) || { echo "Invalid choice: $choice. Try again." >&2; continue 2; }
            # If valid, echo the choice and its number.
            # echo "Choice #$(( ++i )): ${choices[choice-1]} ($choice)"
            # getfromselect ${choices[choice-1]}
            echo ${choices[choice-1]} >> $GIT_PLAT
            echo "add ${choices[choice-1]}"
        done
        # All choices are valid, exit the prompt.
        break
    done

}
#-------------------------------------------------------
# 终端分割线
#-------------------------------------------------------
function fg() {
    shellwidth=`stty size|awk '{print $2}'`
    yes "-" | sed $shellwidth'q' | tr -d '\n'
}
#-------------------------------------------------------
# 提交到的平台选择
#-------------------------------------------------------
function select-platform() {
    # echo " ------------ "
    fg
    PS3="选择你要PUSH的平台序号:"
    select i in all $(cat $GIT_PLAT) exit 
    do 
        if [[ $i == "exit" ]] ; then 
            exit 0
        elif [[ $i == "gitea" ]] ; then
            git remote set-url origin  ${GITEA_HEAD}/$GIT_NAME && git push \
            && echo "Push to ${GITEA_HEAD}/$GIT_NAME Success"
            break
        elif [[ $i == "gitee" ]] ; then 
            git remote set-url origin ${GITEE_HEAD}/$GIT_NAME && git push \
            && echo "Push to ${GITEE_HEAD}/$GIT_NAME Success"
            break
        elif [[ $i == "github" ]] ; then 
            git remote set-url origin ${GITHUB_HEAD}/$GIT_NAME && git push \
            && echo "Push to ${GITHUB_HEAD}/$GIT_NAME Success"
            break
        elif [[ $i == 'all' ]] ; then
            git remote set-url origin   ${GITEA_HEAD}/$GIT_NAME && git push \
            && git remote set-url origin  ${GITEE_HEAD}/$GIT_NAME && git push

            for i in $(cat $GIT_PLAT) 
            do
                if [[ "$i" == "gitea" ]] ; then 
                    git remote set-url origin   ${GITEA_HEAD}/$GIT_NAME && git push \
                    && echo "Push to ${GITHUB_HEAD}/$GIT_NAME Success" || echo "Push to ${GITHUB_HEAD}/$GIT_NAME Failed" 
                fi 
            done 
            break 
        fi    
    done 
}

#-------------------------------------------------------
# commit的类型
#-------------------------------------------------------
function commit_type() {
    # echo " -------------------- "
    fg
    PS3="commit的类型:"
    select i in exit "新功能" "直接一次修复bug" "产生diff多次修复bug" "文档" "格式" "重构" "优化" "测试" "回滚到上一个版本" "代码合并" "同步Bug"
    do 
        if [[ $i == "exit" ]] ; then 
            exit 0
        elif [[ $i == "新功能" ]] ; then
            git commit -m "feat:$*" 
            break
        elif [[ $i == "直接一次修复bug" ]] ; then
            git commit -m "fix:$*" 
            break
        elif [[ $i == "产生diff多次修复bug" ]] ; then
            git commit -m "to:$*" 
            break
        elif [[ $i == "文档" ]] ; then
            git commit -m "docs:$*" 
            break
        elif [[ $i == "格式" ]] ; then
            git commit -m "style:$*" 
            break
        elif [[ $i == "重构" ]] ; then
            git commit -m "refactor:$*" 
            break
        elif [[ $i == "优化" ]] ; then
            git commit -m "perf:$*" 
            break
        elif [[ $i == "测试" ]] ; then
            git commit -m "test:$*" 
            break
        elif [[ $i == "回滚到上一个版本" ]] ; then
            git commit -m "revert:$*" 
            break
        elif [[ $i == "代码合并" ]] ; then
            git commit -m "merge:$*" 
            break
        elif [[ $i == "同步Bug" ]] ; then
            git commit -m "sync:$*" 
            break
        fi    
    done 
}


function main() {
    test ! -d .git && echo "This is not a git" && exit 2
    init-config
    test ${#*} -eq 0 && echo "Info:请添加commit描述" && exit 1
    git status
    git add .
    commit_type $*
    select-platform
    
}

# ------------------------------------------------------------
main $* 




