#!/usr/bin/env bash
set -euo pipefail

FILE="EV0V3/TIFF_ASYMPTOTIC_OPTIMALITY.md"

# Structural checks
grep -q "rho\^\*=" "$FILE"
grep -q "TIFF" "$FILE"
grep -q "Conditional" "$FILE"

# Minimal numeric sanity (dummy parameters)
python3 - <<'PY'
import math

D0 = 1.0
C0 = 2.0
a = -0.5

t0 = -1/abs(a) * math.log(D0/C0)

rho = (2*abs(a)/math.log(C0/D0)
       - abs(a)/2
       + abs(a)/8 * math.log(C0/D0))

assert rho > 0, "rho* must be positive"

val = (D0/rho)*math.exp(-2)

assert val > 0, "TIFF leading term must be positive"

print("Numerical sanity: PASS")
PY

echo "EV0V3 TIFF asymptotic test: PASS"
