#!/usr/bin/env bash
set -euo pipefail

# Check:
# (∀t E_t = 0) ⇔ Error(S) = 0

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

all_zero=1
exists=0

for i in "${!D[@]}"; do
  diff=$((D[i]-C[i]))
  if [ "$diff" -gt 0 ]; then
    all_zero=0
    exists=1
  fi
done

# Error(S)
if [ "$exists" -eq 1 ]; then
  ERROR=1
else
  ERROR=0
fi

echo "ALL_ZERO $all_zero"
echo "ERROR $ERROR"

if [ "$all_zero" -eq 1 ] && [ "$ERROR" -eq 0 ]; then
  echo "EQUIVALENCE_HOLDS_ZERO"
  exit 0
elif [ "$all_zero" -eq 0 ] && [ "$ERROR" -eq 1 ]; then
  echo "EQUIVALENCE_HOLDS_POSITIVE"
  exit 0
else
  echo "EQUIVALENCE_FAIL"
  exit 1
fi
