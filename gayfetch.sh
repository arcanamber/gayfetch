#!/bin/bash

# Define system information variables
DATE=$(date +"%Y-%m-%d %H:%M:%S")
USERNAME=$(whoami)
HOSTNAME=$(hostname)
KERNEL=$(uname -r)
CPU=$(grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f 2-)

# Define memory information variables
MEM_TOTAL=$(free -m | awk '/Mem:/ {printf "%d", $2}')
MEM_USED=$(free -m | awk '/Mem:/ {printf "%d", $3}')
MEM_PERCENT=$(free -m | awk '/Mem:/ {printf "%.2f%%", $3/$2*100}')

# Define disk information variables
DISK_TOTAL=$(df -h / | awk '/\// {printf "%s", $2}')
DISK_USED=$(df -h / | awk '/\// {printf "%s", $3}')
DISK_PERCENT=$(df -h / | awk '/\// {printf "%s", $5}')

# Define network information variables
IP_ADDRESS=$(ip addr show | awk '/inet /{print $2}' | sed 's/\/.*//;s/^[ \t]*//')
MAC_ADDRESS=$(ip link show | awk '/ether/{print $2}')

# Output system information
echo -e "\033[1;35m$USERNAME@$HOSTNAME\033[0m"
echo -e "\033[1;37m$(printf '%.0s-' $(seq 1 $(( ${#USERNAME} + ${#HOSTNAME} + 1 ))))\033[0m"
echo -e "\033[1;35mkernel\033[0m: $KERNEL"
echo -e "\033[1;35mcpu\033[0m: $CPU"
echo -e "\033[1;35mram\033[0m: $MEM_USED MB / $MEM_TOTAL MB ($MEM_PERCENT)"
echo -e "\033[1;35mdisk\033[0m: $DISK_USED / $DISK_TOTAL ($DISK_PERCENT)"
# echo -e "\033[1;35mIP Address\033[0m: $IP_ADDRESS"
# echo -e "\033[1;35mMAC Address\033[0m: $MAC_ADDRESS"
