#!/usr/bin/env bash
set -euo pipefail

# Checks: ED(S)>0 ⇔ max_t (D(t)-C(t))_+ > 0

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

ED=0
max_violation=0

for i in "${!D[@]}"; do
  diff=$((D[i]-C[i]))
  if [ "$diff" -gt 0 ]; then
    ED=$((ED + diff))
    if [ "$diff" -gt "$max_violation" ]; then
      max_violation=$diff
    fi
  fi
done

echo "ED $ED"
echo "MAX_POS $max_violation"

if [ "$ED" -gt 0 ] && [ "$max_violation" -gt 0 ]; then
  echo "EQUIVALENCE_HOLDS_POSITIVE"
  exit 0
elif [ "$ED" -eq 0 ] && [ "$max_violation" -eq 0 ]; then
  echo "EQUIVALENCE_HOLDS_ZERO"
  exit 0
else
  echo "EQUIVALENCE_FAIL"
  exit 1
fi
