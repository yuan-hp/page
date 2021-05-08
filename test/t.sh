#!/bin/bash
#################
#系统工具箱v2
#2019年6月10日14:44:36
#################
#1、判读系统是redhat，还是其他
#2、判读用户是否为root
#3、判断工具是否已安装
#4、打印工具箱

#判断系统，根据系统赋不同的安装命令给变量##############################
sys1=`cat /etc/redhat-release | cut -d " " -f1`
sys2=`cat /etc/issue | cut -d " " -f1`
if [[ $sys1 == CentOS || $sys1 == RedHat ]];then
        R_M=yum
elif [  $sys2 == "Debian" ];then
        R_M=apt-get
else
        echo "Unrecorded System Name......"
        exit
fi
#######################判断系统##########################################



#################################################################
#判断登陆的用户是不是root，可以使用系统变量$LOGNAME
user=`echo $LOGNAME`
if [ $user != "root" ];then
        echo 'please use root user action.....'
        exit
fi
###########################判断登陆用户#########################


#################################################################
#判断有无vmstat，iotp工具，没有则安装
which vmstat &>/dev/null
if [ $? -ne 0 ];then
        $R_M install vmstat -y
fi
which iotop &>/dev/null
if [ $? -ne 0 ];then
        $R_M install iotop -y
fi
###############################################################


####################################################################
#cpu_load函数，下面case语句会调用
cpu_load() {
cpu_sy=`vmstat | awk '{ if(NR==3) print $14}'`
cpu_us=`vmstat | awk '{ if(NR==3) print $15}'`
cpu_wa=`vmstat | awk '{ if(NR==3) print $16}'`
        for i in `seq 3`
        do
        echo -e "\e[1;35m  Real-time value $i \e[1;0m"
        echo -e "\e[1;34m  system time $cpu_sy \e[1;0m"
        echo -e "\e[1;34m  cpu free ${cpu_us}% \e[1;0m"
        echo -e "\e[1;34m  io wait $cpu_wa \e[1;0m"
                sleep 1
        done
}
#########################################################################
#disk_load函数，下面case语句会调用
disk_load() {
        util=`iostat -x -k | awk 'BEGIN{ OFS=": "} /^[v|s]/ { print $1,$NF"%"}'`
        readi=`iostat -x -k | awk 'BEGIN{ OFS=": "} /^[s|v]/ { print $1,$4"kb/s" }'`
        write=`iostat -x -k | awk 'BEGIN{ OFS=": "} /^[s|v]/ { print $1,$5"kb/s" }'`
        echo "util is:\n $util"
        echo "read is:\n$readi"
        echo "write is:\n$write"
}
######################################################################


#这个PS3实际是系统变量，可以自行定义,这里是为了美观，不然输出的格式为#?，比较丑
PS3="please enter your choice(1~9): "
#while循环是重复去打印提示信息。这里的提示信息没有使用printf，也没有使用EOF，而是select。这种格式很像for i in ... do done，不过格式不能自定义，
只能按照它的1，2,3..... 中间穿插case语句匹配select语句中的选项。
while :
do
select info in cpu_load disk_load disk_use disk_inode mem_use tcp_status cpu_top10 mem_top10 quit
do
        clear
        case  $info in
        cpu_load)
                cpu_load
        break
;;
        disk_load)
                    disk_load
        break
;;
        disk_use)
                df -h
        break
;;
        disk_inode)
                echo "disk inode"
        break
;;
        mem_use)
                free -m
        break
;;
        tcp_status)
                ss -an |grep ESTAB | grep '\<22\>'
        break
;;
        cpu_top10)
                ps aux|head -1;ps aux|grep -v PID|sort -rn -k +3| head -10
        break
;;
        mem_top10)
                ps aux|head -1;ps aux|grep -v PID|sort -rn -k +4|head -10
        break
;;
        quit)
                exit
;;
        *)
                echo "error,please enter 1-9"
        break
        esac
done
done