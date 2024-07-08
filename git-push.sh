#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: git-push
#	Author		：hpy
#	Date		：2024年07月08日
#	Description	：git 规范化推送 
#   https://zhuanlan.zhihu.com/p/182553920
#-------------------------------------------------------

# 仓库平台前缀,环境变量中添加
# test -z $GITEE_PREX && GITEE_PREX="https://yuan_hp:token@gitee.com/yuan_hp"
# test -z $GITEA_PREX && GITEA_PREX="http://yhp:token@120.46.47.28:3000/yhp"
# test -z $GITHUB_PREX && GITHUB_PREX="https://yuan-hp:token@github.com/yuan-hp"

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

function giturl() {
    cat $1 | cut -d'@' -f2
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
            git remote set-url origin  ${GITEA_PREX}/$GIT_NAME && git push \
            && echo "Gitea:Push to $(giturl ${GITEA_PREX}) Success"  || echo "Gitea:Push to $(giturl ${GITEA_PREX})/$GIT_NAME Failed"
            break
        elif [[ $i == "gitee" ]] ; then 
            git remote set-url origin ${GITEE_PREX}/$GIT_NAME && git push \
            && echo "Gitee:Push to $(giturl ${GITEE_PREX})/$GIT_NAME Success"  || echo "Gitee:Push to $(giturl ${GITEA_PREX})/$GIT_NAME Failed"
            break
        elif [[ $i == "github" ]] ; then 
            git remote set-url origin ${GITHUB_PREX}/$GIT_NAME && git push \
            && echo "Github:Push to $(giturl ${GITHUB_PREX})/$GIT_NAME Success"  || echo "Github:Push to $(giturl ${GITEA_PREX})/$GIT_NAME Failed"
            break
        elif [[ $i == 'all' ]] ; then
            for i in $(cat $GIT_PLAT) 
            do
                if [[ "$i" == "gitea" ]] ; then 
                    git remote set-url origin   ${GITEA_PREX}/$GIT_NAME && git push \
                    && echo "Gitea:Push to $(giturl ${GITEA_PREX})/$GIT_NAME Success" || echo "Gitea:Push to $(giturl ${GITEA_PREX})/$GIT_NAME Failed"  
                elif [[ "$i" == "gitee" ]] ; then 
                    git remote set-url origin   ${GITEE_PREX}/$GIT_NAME && git push \
                    && echo "Gitee:Push to $(giturl ${GITEE_PREX})/$GIT_NAME Success" || echo "Gitee:Push to $(giturl ${GITEE_PREX})/$GIT_NAME Failed" 
                elif [[ "$i" == "github" ]] ; then 
                    git remote set-url origin   ${GITHUB_PREX}/$GIT_NAME && git push \
                    && echo "Github:Push to $(giturl ${GITHUB_PREX})/$GIT_NAME Success" || echo "Github:Push to $(giturl ${GITHUB_PREX})/$GIT_NAME Failed" 
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
    select i in exit "新功能" "直接一次修复bug" "产生diff多次修复bug" "文档" "格式" "重构" "优化" "测试" "回滚到上一个版本" "代码合并" "同步Bug" "过程或辅助工具变动"
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
        elif [[ $i == "过程或辅助工具变动" ]] ; then
            git commit -m "chore:$*" 
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




