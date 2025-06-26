#!/bin/bash

set -euo pipefail

# Check for required arguments
if [ "$#" -lt 3 ]; then
  echo "Usage: $0 [directory] [mode] [value]"
  echo "Modes: prefix, suffix, replace:<old>:<new>"
  exit 1
fi

DIR="$1"
MODE="$2"
VALUE="$3"

# Check directory
if [ ! -d "$DIR" ]; then
  echo "[ERROR] Directory does not exist: $DIR"
  exit 2
fi

cd "$DIR"

for FILE in *; do
  [ -f "$FILE" ] || continue  # Skip if not a file

  case "$MODE" in
    prefix)
      NEW_NAME="${VALUE}${FILE}"
      ;;
    suffix)
      BASENAME="${FILE%.*}"
      EXT="${FILE##*.}"
      NEW_NAME="${BASENAME}${VALUE}.${EXT}"
      ;;
    replace:*)
      OLD=$(echo "$MODE" | cut -d: -f2)
      NEW=$(echo "$MODE" | cut -d: -f3)
      NEW_NAME="${FILE//$OLD/$NEW}"
      ;;
    *)
      echo "[ERROR] Invalid mode: $MODE"
      exit 3
      ;;
  esac

  if [ "$FILE" != "$NEW_NAME" ]; then
    mv -i "$FILE" "$NEW_NAME"
    echo "Renamed: $FILE → $NEW_NAME"
  fi
done
