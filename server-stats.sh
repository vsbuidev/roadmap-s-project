#!/bin/bash

# to display CPU usage
echo "CPU usage: " $(top -bn1 | grep "Cpu(s)" | awk '{printf "%.2f%%\n", 100 - $8}')

# to display meemory usage
echo "Memory usage: " $(free -m | awk 'NR==2{printf "Used: %dMB / Total: %dMB (%.2f%%)\n", $3, $2, $3*100/$2}')

# to display disk usage
echo "Disk usage: " $(df -h --total | grep total | awk '{printf "Used: %s / Total: %s (%s used)\n", $3, $2, $5}')

# to display top 5 processes by CPU & memory usage
echo "Top 5 processes by CPU usage: " $(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)
echo "Top 5 processes by memory usage: " $(ps -eo pid,comm,%mem --sort=-%mem | head -n 6)

# to get OS Version
echo "OS Version: " $(cat /etc/os-release | grep -E "PRETTY_NAME" | cut -d '=' -f 2)

#to display uptime and load average
echo "Uptime: " $(uptime -p)

# to display currently logged-in users
echo "Logged-in users: " $(who | awk '{print $1}' | sort | uniq -c)

# to display failed login attempts
echo "Failed login attempts: " $(grep "Failed password" /var/log/auth.log 2>\dev\null | wc -l || echo "Log file not found (or) no failed attempts")