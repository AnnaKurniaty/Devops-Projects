#!/bin/bash

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED/$MEM_TOTAL)*100}")

DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')

TOP_CPU_PROCESSES=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)

TOP_MEM_PROCESSES=$(ps -eo pid,comm,%mem --sort=-%mem | head -n 6)

OS_VERSION=$(lsb_release -d | cut -f2-)
UPTIME=$(uptime -p)
LOAD_AVERAGE=$(uptime | awk -F 'load average:' '{print $2}')
LOGGED_IN_USERS=$(who | wc -l)
FAILED_LOGINS=$(grep "Failed password" /var/log/auth.log | wc -l)

echo "==============================="
echo "       SERVER STATS          "
echo "==============================="
echo "CPU Usage: $CPU_USAGE"
echo ""
echo "Memory Usage:"
echo "  Total: ${MEM_TOTAL}MB"
echo "  Used: ${MEM_USED}MB"
echo "  Free: ${MEM_FREE}MB"
echo "  Usage: ${MEM_PERCENT}%"
echo ""
echo "Disk Usage:"
echo "  Total: ${DISK_TOTAL}"
echo "  Used: ${DISK_USED}"
echo "  Free: ${DISK_FREE}"
echo "  Usage: ${DISK_PERCENT}"
echo ""
echo "Top 5 Processes by CPU Usage:"
echo "$TOP_CPU_PROCESSES"
echo ""
echo "Top 5 Processes by Memory Usage:"
echo "$TOP_MEM_PROCESSES"
echo ""
echo "==============================="
echo "       EXTRA STATS             "
echo "==============================="
echo "OS Version: $OS_VERSION"
echo "Uptime: $UPTIME"
echo "Load Average: $LOAD_AVERAGE"
echo "Logged-in Users: $LOGGED_IN_USERS"
echo "Failed Login Attempts: $FAILED_LOGINS"
echo "==============================="
