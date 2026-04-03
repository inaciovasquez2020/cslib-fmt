#!/usr/bin/env bash
set -euo pipefail

# Full system test:
# Validates:
# 1) E_t = max(0, D-C)
# 2) ED = sum E_t
# 3) Error>0 ⇔ ∃ t: D>C

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
    Et=$diff
    exists=1
  else
    Et=0
  fi

  ED=$((ED + Et))

  echo "t=$i D=$d C=$c E_t=$Et"
done

echo "ED $ED"
echo "EXISTS $exists"

# equivalence check
if [ "$ED" -gt 0 ] && [ "$exists" -eq 1 ]; then
  echo "EQUIVALENCE_HOLDS_POSITIVE"
  exit 0
elif [ "$ED" -eq 0 ] && [ "$exists" -eq 0 ]; then
  echo "EQUIVALENCE_HOLDS_ZERO"
  exit 0
else
  echo "EQUIVALENCE_FAIL"
  exit 1
fi
