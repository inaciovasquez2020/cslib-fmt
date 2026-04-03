#!/usr/bin/env bash
set -euo pipefail

# Stress test: detect large-gap violation D(t) >> C(t)

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

threshold=${THRESHOLD:-10}

for i in "${!D[@]}"; do
  diff=$((D[i]-C[i]))
  if [ "$diff" -ge "$threshold" ]; then
    echo "STRESS_VIOLATION t=$i GAP=$diff"
    exit 1
  fi
done

echo "NO_STRESS_VIOLATION"
exit 0
