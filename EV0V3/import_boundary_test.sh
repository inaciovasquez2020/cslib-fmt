#!/usr/bin/env bash
set -euo pipefail

ROOT="EV0V3"
INTERFACE="$ROOT/INTERFACE.md"

test -d "$ROOT"
test -f "$INTERFACE"

grep -q '^Status: isolated namespace$' "$INTERFACE"
grep -q 'No direct import into `FMT.Graph` yet\.' "$INTERFACE"
grep -q 'No mutation of existing graph-distance semantics\.' "$INTERFACE"
grep -q 'Integration only through explicit bridge modules\.' "$INTERFACE"

LEAN_FILES="$(find EV0V3 -maxdepth 2 -type f -name '*.lean')"
if [ -n "$LEAN_FILES" ]; then
  if grep -n '^import FMT\.Graph' $LEAN_FILES; then
    echo "FAIL: direct FMT.Graph import detected inside EV0V3 Lean files"
    exit 1
  fi
fi

echo "EV0V3 import boundary test: PASS"
