#!/usr/bin/env bash
set -euo pipefail

# Weighted ED: ED_w = sum w_t * max(0, D(t)-C(t))
# Usage: ./fas_weighted.sh d1 d2 ... -- c1 c2 ... -- w1 w2 ...

args=("$@")
split1=0
split2=0

for i in "${!args[@]}"; do
  if [ "${args[$i]}" = "--" ]; then
    if [ "$split1" -eq 0 ]; then
      split1=$i
    else
      split2=$i
      break
    fi
  fi
done

D=("${args[@]:0:$split1}")
C=("${args[@]:$((split1+1)):$((split2-split1-1))}")
W=("${args[@]:$((split2+1))}")

if [ "${#D[@]}" -ne "${#C[@]}" ] || [ "${#D[@]}" -ne "${#W[@]}" ]; then
  echo "MISMATCH_LENGTH"
  exit 2
fi

EDW=0

for i in "${!D[@]}"; do
  diff=$((D[i]-C[i]))
  if [ "$diff" -gt 0 ]; then
    EDW=$((EDW + diff * W[i]))
  fi
done

echo "ED_WEIGHTED $EDW"

if [ "$EDW" -gt 0 ]; then
  exit 1
else
  exit 0
fi
