#!/usr/bin/env bash
set -euo pipefail

# Usage: ./fas_exists_violation.sh d1 d2 d3 ... -- c1 c2 c3 ...
# Example: ./fas_exists_violation.sh 5 3 8 -- 4 4 4

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

for i in "${!D[@]}"; do
  if [ "${D[$i]}" -gt "${C[$i]}" ]; then
    echo "EXISTS_VIOLATION t=$i D=${D[$i]} C=${C[$i]}"
    exit 1
  fi
done

echo "NO_VIOLATION"
exit 0
