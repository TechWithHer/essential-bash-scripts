#!/bin/bash

# Enable strict error handling
set -euo pipefail

# Check input arguments
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 [target_directory] [file_pattern] [days_old]"
  exit 1
fi

TARGET_DIR="$1"
PATTERN="$2"
DAYS="$3"

# Check if the directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "[ERROR] Directory does not exist: $TARGET_DIR"
  exit 2
fi

# Find and delete files matching pattern older than X days
find "$TARGET_DIR" -type f -name "$PATTERN" -mtime +"$DAYS" -print -delete

echo "[INFO] Old log files matching '$PATTERN' older than $DAYS days deleted from $TARGET_DIR"
