#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: makelist.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：创建脚本资源库数据
#-------------------------------------------------------

src=$(find deepin cygwin -type f -name "*" -print )

echo $src > pkg.all