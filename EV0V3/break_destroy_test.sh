#!/usr/bin/env bash
set -euo pipefail

ROOT="EV0V3"
FILE="$ROOT/README.txt"
BACKUP="$ROOT/README.txt.bak"

validate() {
  test -d "$ROOT"
  test -f "$FILE"
  grep -qx 'EV0V3' "$FILE"
}

printf 'phase=baseline\n'
validate

printf 'phase=break-remove-file\n'
mv "$FILE" "$BACKUP"
if validate 2>/dev/null; then
  echo "FAIL: validation passed after destruction"
  mv "$BACKUP" "$FILE"
  exit 1
else
  echo "PASS: destruction detected"
fi

printf 'phase=restore\n'
mv "$BACKUP" "$FILE"
validate

printf 'phase=break-corrupt-content\n'
printf 'CORRUPTED\n' > "$FILE"
if validate 2>/dev/null; then
  echo "FAIL: validation passed after corruption"
  printf 'EV0V3\n' > "$FILE"
  exit 1
else
  echo "PASS: corruption detected"
fi

printf 'phase=restore-final\n'
printf 'EV0V3\n' > "$FILE"
validate

echo "EV0V3 break/destroy test: PASS"
