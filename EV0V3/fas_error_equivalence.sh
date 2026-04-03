#!/usr/bin/env bash
set -euo pipefail

# Conditional check:
# Error(S) = ED(S)
# Here we operationalize Error(S) := indicator(∃ t: D>C)

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
exists=0

for i in "${!D[@]}"; do
  d=${D[i]}
  c=${C[i]}
  diff=$((d - c))

  if [ "$diff" -gt 0 ]; then
    ED=$((ED + diff))
    exists=1
  fi
done

# define Error(S)
if [ "$exists" -eq 1 ]; then
  ERROR=1
else
  ERROR=0
fi

echo "ED $ED"
echo "ERROR $ERROR"

# check implication structure
if [ "$ERROR" -eq 0 ] && [ "$ED" -eq 0 ]; then
  echo "CONSISTENT_ZERO"
  exit 0
elif [ "$ERROR" -eq 1 ] && [ "$ED" -gt 0 ]; then
  echo "CONSISTENT_POSITIVE"
  exit 0
else
  echo "INCONSISTENT"
  exit 1
fi
