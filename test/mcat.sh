#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: mcat.sh
#	Author		：hpy
#	Date		：2021年08月19日
#	Description	：自动将文件编码转为UTF8后输出显示
#                 mcat filename
#-------------------------------------------------------
 
#UFUNCTION=自动将文件编码转为UTF8后输出显示
f=$1 
var=$(file -i $f)
code=$(echo $var | cut -d '=' -f2 | tr [a-z] [A-Z])
# echo $code 
iconv -f $code -t UTF-8 $f  | tr '\r' ' '