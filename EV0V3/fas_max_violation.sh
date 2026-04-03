#!/usr/bin/env bash
set -euo pipefail

# Usage: ./fas_max_violation.sh d1 d2 ... -- c1 c2 ...
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

max_violation=0
argmax=0

for i in "${!D[@]}"; do
  diff=$((D[i]-C[i]))
  if [ "$diff" -gt "$max_violation" ]; then
    max_violation=$diff
    argmax=$i
  fi
done

echo "MAX_VIOLATION $max_violation at t=$argmax"

if [ "$max_violation" -gt 0 ]; then
  exit 1
else
  exit 0
fi
