#!/bin/bash

set -euo pipefail

if [ "$#" -ne 2 ]; then
 echo "Usage: $0 [source_path] [backup_destination]"
 exit 1 
fi

SOURCE="$1"
DEST="$2"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BASENAME=$(basename "$SOURCE")
BACKUP_NAME="${BASENAME}_backup_${TIMESTAMP}.tar.gz"
LOG_FILE="backup.log"

if [ ! -e "$SOURCE" ]; then
  echo "[ERROR] Source path does not exist: $SOURCE"
  exit 2
fi

mkdir -p "$DEST"
tar -czf "$DEST/$BACKUP_NAME" "$SOURCE"
echo "[SUCCESS] $(date +"%F %T") - Backup of '$SOURCE' saved as '$DEST/$BACKUP_NAME'" >> "$LOG_FILE"
echo "Backup completed successfully: $DEST/$BACKUP_NAME"

