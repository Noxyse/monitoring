#!/usr/bin/bash

LOG_FILE="/var/log/auth.log"
EMAIL="noxise.nox@gmail.com"

#tail -F "$LOG_FILE" | while read LINE; do
#	echo "$LINE" | grep 'Accepted password for' && \
#	echo "SSH Login Alert: $LINE" | mail -s "SSH Login Alert" "$EMAIL"
#done

THRESHOLD=10

# Get the current CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *$[0-9]*$%* id.*/\1/" | awk '{print 100 - $1}')

# Check if CPU usage is above the threshold
if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
    echo "CPU usage is above threshold: ${CPU_USAGE}%" | mail -s "CPU Alert" noxise.nox@gmail.com
fi

