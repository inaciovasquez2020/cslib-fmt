#!/usr/bin/env bash
set -euo pipefail

# Nuclear break test: detect unbounded growth D(t) - C(t) → +∞ (threshold-based proxy)

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

threshold=${THRESHOLD:-100}

max_gap=0

for i in "${!D[@]}"; do
  diff=$((D[i]-C[i]))
  if [ "$diff" -gt "$max_gap" ]; then
    max_gap=$diff
  fi
done

echo "MAX_GAP $max_gap"

if [ "$max_gap" -ge "$threshold" ]; then
  echo "UNBOUNDED_PROXY_TRIGGERED"
  exit 1
else
  echo "BOUNDED_REGIME"
  exit 0
fi
