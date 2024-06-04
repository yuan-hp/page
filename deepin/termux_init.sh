#!/bin/bash
#-------------------------------------------------------
#	FileName	: termux_config.sh
#	Author		：hpy
#	Date		：2023年11月20日
#	Description	：termux环境配置 
#-------------------------------------------------------

#!/bin/bash 

cd $HOME 

function check() {
    test $? -ne 0 && echo "$1 failed" && exit 1
}

#p0: 配置密码 123456
#passwd
test ! -d bin && mkdir bin 
test ! -d soft && mkdir soft 
test ! -d work && mkdir work 

#p1 : 更新仓库
pkg update 
check "update"

#p2: 安装基本的软件 
pkg install vim clang openssh bison python python3 tcl make ssh git php xmake lua53 fish -y
passwd 

#p3: 配置ssh 

# 生成.bashrc

printf "\#!/bin/bash
  
\#----------------------
\#自启动程序
\#param1：应用名称 
\#param2：启动指令
\#---------------------- 
function autostart() {
  if pgrep -x \"$1\" >/dev/null
    then
      echo \"$1运行中...\"
    else
      eval \"$2\"
      echo \"自动启动$1\"
   fi
}

 \# sshd自动启动
autostart \"sshd\" \"sshd\"
\#autostart \"php\"  \"nohup php -S 0.0.0.0:4000 -t $HOME/work/blog &\"

whoami
 
" > .bashrc 

echo "export PATH=$PATH:$HOME/bin" > $HOME/.bashrc 

#p4: 配置fish 

cd $HOME/.config 
rm -rf fish 
git clone https://gitee.com/yuan_hp/fish.git


cd $HOME 

#p5: 配置vim
git clone https://gitee.com/yuan_hp/vim.git
cd vim
chmod +x ./vim-config-install.sh
./vim-config-install.sh

cd $HOME 

#p6: 安装 个人脚本管理工具 mpkg  
curl https://gitee.com/yuan_hp/page/raw/master/pkg > $HOME/bin/mpkg 
chmod +x  $HOME/bin/mpkg 


