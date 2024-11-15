#!/usr/bin/bash

# Function to install missing packets



# Trap to restor cursor visibility and position
trap 'tput cnorm; tput cup $(tput lines)0' EXIT

# Hide cursor
tput civis

# Colours
RED="\e[0;31m"
GREEN="\e[0;32m"
BLUE="\e[0;34m"
RES="\033[0m"

# Table layout
draw_table() {
	clear
	#               10        20        30        40        50        60        70        80 
	#     012345678901234567890123456789012345678901234567890123456789012345678901234567890123
	echo "==========================================  ========================================"
	echo "            SYSTEM  INFORMATION                         DISK INFORMATION            "
	echo "==========================================  ========================================"
	echo " Current Time:                              ┌─sda1─────────────────────────────────┐"
	echo "       Uptime:                              │  Size:              Read:       kB/s │"  
	echo "                                            │  Used:              Wrtn:       kB/s │"
	echo " CPU Usage:                             %   │ Avail:                               │" 
	echo " RAM Usage:                             %   │                                      │"
	echo "                                            └──────────────────────────────────────┘"	
	echo "=========================================="
	echo "                  NETWORK                 "
	echo "=========================================="
	echo " IP Address:                              "
	echo "                                          "
	echo " RX-OK:             TX-OK:                "
	echo " RX-ERR:            TX-ERR:               "
	echo " RX-DRP:            TX-DRP:               "
	echo ""
	echo "===================================================================================="
	echo "                            TOP 10 SERVICES BY CPU USAGE                            "
	echo "===================================================================================="
	echo "                               "
}

draw_table
	
#---TOP 10 SERVICES BY CPU USAGE---
top10_user=$(ps aux --sort=-%cpu | tail -n +2 | grep -v "ps aux" |  head -n 10 | awk '{printf "%s %s %s %.2f%% \n", $1, $2, $11, $3}')	
tput cup 22 0
echo -ne "$top10_user"


#---DISK INFO---
# Size
size=$(df -h | grep "sda1" | awk '{print $2}')
tput cup 4 53
echo -ne "$size"

# Used space
used=$(df -h | grep "sda1" | awk '{print $3}')
tput cup 5 53
echo -ne "$used"
	
# Space available
avail=$(df -h | grep "sda1" | awk '{print $4}')
tput cup 6 53
echo -ne "$avail"

# Read speed
read=$(iostat | grep "sda" | awk '{print $3}')
tput cup 4 72
echo -ne "$read"

# Write  speed
write=$(iostat | grep "sda" | awk '{print $4}')
tput cup 5 72
echo -ne "$write"
	
#---SYSTEM INFO---	
# Current time
current_time=$(date +"%Y-%b-%d %H:%M:%S")
tput cup 3 19
echo -ne "$current_time"

# Uptime
uptime=$(uptime -p)
tput cup 4 19
echo -ne "$uptime"

# Current CPU usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')
tput cup 6 37
echo -ne "$CPU"
	
# Current RAM usage
RAM=$(free | awk '/Mem/{print int($3/$2*100)}')
tput cup 7 37
echo -ne "$RAM"
	
#---NETWORK---
# IP Address
IP=$(ifconfig eth0 | grep "inet " | awk '{print $2}')
tput cup 12 30
echo -ne "$IP"

# Packets
RX_OK=$(netstat -ni | awk -v interface="eth0" '$1 == interface {print $3}')
tput cup 14 9
echo -ne "$RX_OK"

RX_ERR=$(netstat -ni | awk -v interface="eth0" '$1 == interface {print $4}')
tput cup 15 9
echo -ne "$RX_ERR"

RX_DRP=$(netstat -ni | awk -v interface="eth0" '$1 == interface {print $5}')
tput cup 16 9
echo -ne "$RX_DRP"

TX_OK=$(netstat -i | awk -v interface="eth0" '$1 == interface {print $7}')
tput cup 14 28
echo -ne "$TX_OK"

TX_ERR=$(netstat -ni | awk -v interface="eth0" '$1 == interface {print $8}')
tput cup 15 28
echo -ne "$TX_ERR"

TX_DRP=$(netstat -ni | awk -v interface="eth0" '$1 == interface {print $9}')
tput cup 16 28
echo -ne "$TX_DRP"
	

tput cnorm
