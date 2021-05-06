#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: tplot.sh
#	Author		：hpy
#	Date		：2021年04月25日
#	Description	：终端条状图
#-------------------------------------------------------
#UFUNCTION=终端条状图
# Bash, with GNU sleep
spin() {
  local i=0
  local sp='/-\|'
  local n=${#sp}
  printf ' '
  sleep 0.1
  while true; do
    printf '\b%s' "${sp:i++%n:1}"
    sleep 0.1
  done
}

spin