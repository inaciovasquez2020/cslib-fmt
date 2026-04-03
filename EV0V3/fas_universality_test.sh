#!/usr/bin/env bash
set -euo pipefail

# Universality stress extension:
# Tests robustness under injected "hidden capacity" perturbation
# Goal: detect violation of admissibility assumptions

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

# inject hypothetical hidden/global capacity
HIDDEN_SHIFT=${HIDDEN_SHIFT:-0}

ED=0
exists=0

for i in "${!D[@]}"; do
  d=${D[i]}
  c=$((C[i] + HIDDEN_SHIFT))  # simulate hidden capacity

  diff=$((d - c))

  if [ "$diff" -gt 0 ]; then
    ED=$((ED + diff))
    exists=1
  fi
done

echo "HIDDEN_SHIFT $HIDDEN_SHIFT"
echo "ED $ED"
echo "EXISTS $exists"

# detect admissibility violation
if [ "$HIDDEN_SHIFT" -gt 0 ] && [ "$exists" -eq 0 ]; then
  echo "HIDDEN_CAPACITY_BREAKS_MODEL"
  exit 1
else
  echo "MODEL_STABLE"
  exit 0
fi
