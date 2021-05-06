#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: wave.sh
#	Author		：hpy
#	Date		：2021年05月04日
#	Description	： 简单时序终端显示脚本
#-------------------------------------------------------
#UFUNCTION=简单时序终端显示脚本

#---------------- 参数 ---------------
s1="d|"
s2="d|"
DIS_LEN=2  #放大比例
#------------------------------------

IDX=0
mcol=$(stty size | awk '{print $2}')
#显示填充样式


STYLE1=""
STYLE2=""
for ((num=0;num<DIS_LEN;num++))
do 
	STYLE1="${STYLE1}_"
	STYLE2="${STYLE2} "
done 

#----------------------------

function mecho () {
	#  echo -e "\e[1;40m$1\e[0m"
	 echo "$1"
}
function clc() {
	s1="$kDX|"
	s2="$kDX|"
	IDX=$((IDX+1))
}
function high() {
	s1="${s1}${STYLE1}_"
	s2="${s2}${STYLE2} "
}

function low() {
	s1="${s1}${STYLE2} "
	s2="${s2}${STYLE1}_"
}

function posedge() {
	s1="${s1} ${STYLE1}"
	s2="${s2}/${STYLE2}"
}

function negedge() {
	s1="${s1} ${STYLE2}"
	s2="${s2}\\${STYLE1}"
}
function mdispaly() {
	mecho "${s1}" 
	mecho "${s2}" 
}

#按列读取时序
#@param1时序文件 $1
function loadColumn() {
	test ! -f $1 && mecho "no file $1" && exit 
	clc 
	local i=0
	data=$(cat $1 | awk '{print $1}')
	local last=0
	for k in $data 
	do 
		if [ $i -eq 0 ] ; then 
			test $k -eq 0 && low || high 
			last=$k
			i=$((i+1))
		else 
			if [ $k -eq 0 ] ; then 
				if [ $last -eq 0 ] ; then 
					low 
				else 
					negedge 
					# low 
				fi
				last=$k 
			else   #1
				if [ $last -eq 0 ] ; then 
					posedge 
					# high 
				else 
					high
				fi
				last=$k 				
			fi 
			i=$((i+1))
		fi 
	done 

	mdispaly 
}

#按行读取时序
# @param时序文件 $1
# @param2 第几行
function loadLine() {
	test ! -f $1 && mecho "no file $1" && exit 
	local linenum=1
	if [ ! -z $2 ] ;then 
		linenum=$2
	fi 
	clc 
	local i=0
	ldata=$(sed -n "${linenum}p" $1)
	local len=${#ldata}
	local idx=0
	local data=""
	#分割数据
	while test $idx -lt $len 
	do 
		data="${data} ${ldata:$idx:1}"
		idx=$((idx+1))
	done 

	local last=0
	for k in ${data}
	do 
		if [ $i -eq 0 ] ; then 
			test $k -eq 0 && low || high 
			last=$k
			i=$((i+1))
		else 
			if [ $k -eq 0 ] ; then 
				if [ $last -eq 0 ] ; then 
					low 
				else 
					negedge 
					# low 
				fi
				last=$k 
			else   #1
				if [ $last -eq 0 ] ; then 
					posedge 
					# high 
				else 
					high
				fi
				last=$k 				
			fi 
			i=$((i+1))
		fi 
	done 

	mdispaly 
}

#直接处理字符串
# @param1 字符串
function loadStr() {
	clc 
	local i=0
	ldata=$1
	local len=${#ldata}
	local idx=0
	local data=""
	#分割数据
	while test $idx -lt $len 
	do 
		data="${data} ${ldata:$idx:1}"
		idx=$((idx+1))
	done 

	local last=0
	for k in ${data}
	do 
		if [ $i -eq 0 ] ; then 
			test $k -eq 0 && low || high 
			last=$k
			i=$((i+1))
		else 
			if [ $k -eq 0 ] ; then 
				if [ $last -eq 0 ] ; then 
					low 
				else 
					negedge 
					# low 
				fi
				last=$k 
			else   #1
				if [ $last -eq 0 ] ; then 
					posedge 
					# high 
				else 
					high
				fi
				last=$k 				
			fi 
			i=$((i+1))
		fi 
	done 

	mdispaly 
}
#行存储的时序全部显示
# @param1 ： 时序文件
function loadLineAll(){
	test ! -f $1 && mecho "no file $1" && exit 
	while read line 
	do 
		loadStr $line 
	done < $1	
}

# loadColumn t.dat  > wave.txt 
# loadLineAll t1.dat #> wave.txt 

function mhelp () {
	echo 
	echo " Usage: wave filename [line]"
	echo "	wave filename        显示所有波形"
	echo "	wave filename  line  示所第line行的波形"
	echo 
}

function main() {
	local str=""
	local idx=1
	for i in $* 
	do 
		test $idx -gt 1 && str="${str} $i"
	done 
	if [  -f $1  ] ; then 
		if [ $# -eq 1 ] ; then 
			loadLineAll $1 
		elif [ $# -eq 2 ] ; then 
			loadLine $1 $2
		else 
			mhelp 
		fi 
	else 
		mhelp 
	fi 
}



main $*
