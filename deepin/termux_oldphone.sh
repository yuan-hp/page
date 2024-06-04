#!/bin/bash
#-------------------------------------------------------
#	FileName	: termux_config.sh
#	Author		：hpy
#	Date		：2023年11月20日
#	Description	：termux环境配置 
#-------------------------------------------------------

#!/bin/bash 

cd $HOME 

#p1:更新源
echo " ---------------- 替换安装源 ---------------- " 
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://packages.termux.dev/apt/termux-main-21 stable main@' $PREFIX/etc/apt/sources.list

sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://termux.dev/game-packages-21-bin games stable@' $PREFIX/etc/apt/sources.list.d/game.list

sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://termux.dev/science-packages-21-bin science stable@' $PREFIX/etc/apt/sources.list.d/science.list

# 替换安装源后，执行apt update && apt upgrade可以正常执行
apt update && apt upgrade

echo "出现 public key is not available: NO_PUBKEY  问题,使用 apt-get --fix-broken upgrade ,  安装选yes ;忽略验证选no。升级版本选no"


#p2: 配置ssh 
pkg install openssh
# 生成.bashrc

printf "\#!/bin/bash
\#----------------------
\#自启动程序
\#param1:应用名称 
\#param2:启动指令
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
whoami

" > .bashrc 




