#!/usr/bin/env bash
set -euo pipefail

# Checks: sum FAS^+ = 0 ⇔ no t with D(t) > C(t)

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

sum=0
exists=0

for i in "${!D[@]}"; do
  diff=$((D[i]-C[i]))
  if [ "$diff" -gt 0 ]; then
    sum=$((sum + diff))
    exists=1
  fi
done

if [ "$sum" -eq 0 ] && [ "$exists" -eq 0 ]; then
  echo "EQUIVALENCE_HOLDS_ZERO"
  exit 0
elif [ "$sum" -gt 0 ] && [ "$exists" -eq 1 ]; then
  echo "EQUIVALENCE_HOLDS_POSITIVE sum=$sum"
  exit 0
else
  echo "EQUIVALENCE_FAIL sum=$sum exists=$exists"
  exit 1
fi
