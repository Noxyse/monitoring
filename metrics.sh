#!/usr/bin/bash
csv_file="metrics_$(date +'%Y-%m-%d_%H-%M').csv"

echo "Timestamp, CPU Usage (%), Memory Usage (%)" > "$csv_file"

./single_monitoring.sh >> "$csv_file"
