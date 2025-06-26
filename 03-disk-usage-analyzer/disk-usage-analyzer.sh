#!/bin/bash

set -euo pipefail

# Check for exactly two arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 [directory_path] [threshold_percentage]"
  exit 1
fi

DIR="$1"
THRESHOLD="$2"

# Check if the path exists and is a directory
if [ ! -d "$DIR" ]; then
  echo "[ERROR] Directory does not exist: $DIR"
  exit 2
fi

# Get the disk usage percentage for the filesystem containing the directory
USAGE=$(df -h "$DIR" | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "[WARNING] Disk usage at '$DIR' is ${USAGE}% (Threshold: ${THRESHOLD}%)"
  exit 3
else
  echo "[OK] Disk usage at '$DIR' is ${USAGE}% (Below threshold)"
  exit 0
fi
