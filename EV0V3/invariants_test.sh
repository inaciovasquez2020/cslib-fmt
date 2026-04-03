#!/usr/bin/env bash
set -euo pipefail

ROOT="EV0V3"
README="$ROOT/README.txt"
INTERFACE="$ROOT/INTERFACE.md"

test -d "$ROOT"
test -f "$README"
test -f "$INTERFACE"
grep -qx 'EV0V3' "$README"
grep -q '^Status: isolated namespace$' "$INTERFACE"
grep -q 'No direct import into `FMT.Graph` yet\.' "$INTERFACE"
grep -q 'Integration only through explicit bridge modules\.' "$INTERFACE"

echo "EV0V3 invariants test: PASS"
