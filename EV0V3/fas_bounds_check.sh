#!/usr/bin/env bash
set -euo pipefail

# Checks bounds:
#   sum(D - C) ≤ ED(S) ≤ sum(D)

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

sum_D=0
sum_diff=0
ED=0

for i in "${!D[@]}"; do
  d=${D[i]}
  c=${C[i]}
  diff=$((d - c))

  sum_D=$((sum_D + d))
  sum_diff=$((sum_diff + diff))

  if [ "$diff" -gt 0 ]; then
    ED=$((ED + diff))
  fi
done

echo "SUM_D $sum_D"
echo "SUM_DIFF $sum_diff"
echo "ED $ED"

lower_ok=0
upper_ok=0

if [ "$ED" -ge "$sum_diff" ]; then
  lower_ok=1
fi

if [ "$ED" -le "$sum_D" ]; then
  upper_ok=1
fi

if [ "$lower_ok" -eq 1 ] && [ "$upper_ok" -eq 1 ]; then
  echo "BOUNDS_OK"
  exit 0
else
  echo "BOUNDS_FAIL lower_ok=$lower_ok upper_ok=$upper_ok"
  exit 1
fi
