#!/usr/bin/env bash
set -euo pipefail

# Usage: ./fas_zero_sum_check.sh d1 d2 ... -- c1 c2 ...

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
for i in "${!D[@]}"; do
  diff=$((D[i]-C[i]))
  if [ "$diff" -gt 0 ]; then
    sum=$((sum+diff))
  fi
done

if [ "$sum" -eq 0 ]; then
  echo "ZERO_SUM_ALL_OK"
  exit 0
else
  echo "NONZERO_SUM $sum"
  exit 1
fi
