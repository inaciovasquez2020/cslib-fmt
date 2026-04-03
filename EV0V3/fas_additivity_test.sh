#!/usr/bin/env bash
set -euo pipefail

# Additivity Test:
# Checks whether ED matches sum(D-C)_+ under additive vs non-additive capacity

args=("$@")
split=0

for i in "${!args[@]}"; do
  if [ "${args[$i]}" = "--" ]; then
    split=$i
    break
  fi
done

D=("${args[@]:0:$split}")
C=("${args[@]:$((split+1))}")

if [ "${#D[@]}" -ne "${#C[@]}" ]; then
  echo "MISMATCH_LENGTH"
  exit 2
fi

ED_local=0

for i in "${!D[@]}"; do
  diff=$((D[i]-C[i]))
  if [ "$diff" -gt 0 ]; then
    ED_local=$((ED_local + diff))
  fi
done

# simulate non-additive coupling
COUPLING=${COUPLING:-0}
ED_coupled=$((ED_local - COUPLING))

echo "ED_LOCAL $ED_local"
echo "ED_COUPLED $ED_coupled"
echo "COUPLING $COUPLING"

if [ "$COUPLING" -eq 0 ]; then
  echo "ADDITIVE_MODEL"
  exit 0
else
  if [ "$ED_coupled" -ne "$ED_local" ]; then
    echo "NON_ADDITIVE_DETECTED"
    exit 1
  else
    echo "DEGENERATE_CASE"
    exit 0
  fi
fi
