#!/bin/bash

LOGS="$1"

if [ -z "$LOGS" ] || [ ! -f "$LOGS" ]; then
    echo "Please provide a valid Log file path"
    exit 1
fi

echo "Top 5 IP addresses with most requests:"
awk '{print $1}' "$LOGS" | sort | uniq -c | sort -rn | head -n 5

echo -e "\nTop 5 requested paths:"
awk '{print $7}' "$LOGS" | sort | uniq -c | sort -rn | head -n 5

echo -e "\nTop 5 response status codes:"
awk '{print $9}' "$LOGS" | sort | uniq -c | sort -rn | head -n 5

echo -e "\nTop 5 user agents:"
awk -F'"' '{print $6}' "$LOGS" | sort | uniq -c | sort -rn | head -n 5
