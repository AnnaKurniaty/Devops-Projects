#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR=$1
ARCHIVE_DIR="$LOG_DIR/archive"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_FILE="$ARCHIVE_DIR/logs_archive_$TIMESTAMP.tar.gz"
LOG_FILE="$ARCHIVE_DIR/archive_log.txt"

mkdir -p "$ARCHIVE_DIR"

tar -czf "$ARCHIVE_FILE" -C "$LOG_DIR" .

echo "[$(date +"%Y-%m-%d %H:%M:%S")] Archived logs to $ARCHIVE_FILE" >> "$LOG_FILE"

echo "Logs archived successfully: $ARCHIVE_FILE"
