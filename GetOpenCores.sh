#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: GetOpenCores.sh
#	Author		：hpy
#	Date		：2024年02月03日
#	Description	：
#-------------------------------------------------------


git_host="https://github.com/org"
tmp_log="repos.log"

username=freecores

function gitclone()
{
    local username=$1
    if [ ! -d $username ];then
        mkdir -p $username
    fi
    cd $username

    # curl https://api.github.com/orgs/$username/repos?per_page=100\&page=1 | grep -o 'git@[^"]*' > $tmp_log
    # curl https://api.github.com/orgs/$username/repos?per_page=100\&page=2 | grep -o 'git@[^"]*' >> $tmp_log
    # curl https://api.github.com/orgs/$username/repos?per_page=100\&page=3 | grep -o 'git@[^"]*' >> $tmp_log  
    # curl https://api.github.com/orgs/$username/repos?per_page=100\&page=4 | grep -o 'git@[^"]*' >> $tmp_log  
    # curl https://api.github.com/orgs/$username/repos?per_page=100\&page=5 | grep -o 'git@[^"]*' >> $tmp_log  
    # curl https://api.github.com/orgs/$username/repos?per_page=100\&page=6 | grep -o 'git@[^"]*' >> $tmp_log  
    # curl https://api.github.com/orgs/$username/repos?per_page=100\&page=7 | grep -o 'git@[^"]*' >> $tmp_log

    cnt=0  
    cat $tmp_log|awk -F: '{print $2}' | while read line  	
    do
        echo "start $cnt ......."
        ((cnt=cnt+1))
        # 找到仓库的名字
        name=$(basename $line)
        # 方式一：下载zip包
        #wget https://codeload.github.com$line/zip/master -O $name.zip
        # 方式二：git clone 
        # git clone $line   
        git clone 	https://kkgithub.com/$line 
    done
    rm $tmp_log
}

gitclone $username

