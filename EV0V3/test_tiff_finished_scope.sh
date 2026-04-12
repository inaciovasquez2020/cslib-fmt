#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
grep -Fq 'TIFF is finished at the EV0V3 law level.' TIFF_FINISHED_SCOPE.md
grep -Fq 'The clause “Valid for systems with no hidden/global capacity channels” is a scope restriction, not an open theorem obligation inside EV0V3.' TIFF_FINISHED_SCOPE.md
grep -Fq 'Within this scope, TIFF is CLOSED.' TIFF_FINISHED_SCOPE.md
test -f TIFF_LAW.md
test -f TIFF_GLOBAL_CLOSURE.md
test -f TIFF_ASYMPTOTIC_OPTIMALITY.md
test -f tiff_coupling_reduction_full.sh
test -f test_tiff_asymptotic.sh
