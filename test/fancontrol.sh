#!/usr/bin/env bash
#-------------------------------------------------------
#	FileName	: fancontrol.sh
#	Author		：hpy
#	Date		：2022年08月03日
#	Description	：风扇转速控制
#-------------------------------------------------------
 
#!/bin/bash
read -p "input speed(0-255) and ENTER: " SPEED
[[ -z $SPEED ]] && SPEED=85
echo $SPEED | sudo tee /sys/class/hwmon/hwmon2/pwm1
