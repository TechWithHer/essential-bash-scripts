#!/bin/bash

set -euo pipefail

# Check if service name is passed
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [service_name]"
  exit 1
fi

SERVICE="$1"

# Check if systemctl is available
if ! command -v systemctl >/dev/null; then
  echo "[ERROR] systemctl is not available on this system."
  exit 2
fi

# Check service status
STATUS=$(systemctl is-active "$SERVICE" 2>/dev/null || echo "not-found")

if [ "$STATUS" == "active" ]; then
  echo "[OK] Service '$SERVICE' is running."
  exit 0
elif [ "$STATUS" == "inactive" ]; then
  echo "[WARNING] Service '$SERVICE' is installed but not running."
  exit 3
elif [ "$STATUS" == "not-found" ]; then
  echo "[ERROR] Service '$SERVICE' does not exist."
  exit 4
else
  echo "[UNKNOWN] Unexpected status '$STATUS'"
  exit 5
fi
