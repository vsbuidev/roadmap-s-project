#!/bin/bash

# default archive directory
DIR="/var/log/archives"

# create the archive directory if it doesn't exist
sudo mkdir -p "$DIR"

# check if a log directory is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR="$1"

# check if the log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

# to generate a TIMEed archive name
TIME=$(date +"%Y%m%d_%H%M%S")
ARC_NAME="logs_archive_${TIME}.tar.gz"
ARC_PATH="${DIR}/${ARC_NAME}"

# to compress logs
tar -czf "$ARC_PATH" -C "$LOG_DIR" .

# log the archive action
echo "$(date +"%Y-%m-%d %H:%M:%S") - Created archive: $ARC_NAME" >> "${DIR}/archive_log.txt"

# output the result
echo "Logs archived to: $ARC_PATH"
