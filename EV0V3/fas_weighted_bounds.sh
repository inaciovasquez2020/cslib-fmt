#!/usr/bin/env bash
set -euo pipefail

# Checks weighted bounds:
# max_t w_t*(D-C)_+ ≤ ED_w ≤ (sum_t w_t)*max_t (D-C)_+

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
sumW=0
max_term=0
max_gap=0

for i in "${!D[@]}"; do
  d=${D[i]}
  c=${C[i]}
  w=${W[i]}

  diff=$((d-c))
  if [ "$diff" -gt 0 ]; then
    term=$((w*diff))
    EDW=$((EDW + term))
    if [ "$term" -gt "$max_term" ]; then
      max_term=$term
    fi
    if [ "$diff" -gt "$max_gap" ]; then
      max_gap=$diff
    fi
  fi
  sumW=$((sumW + w))
done

upper=$((sumW * max_gap))

echo "EDW $EDW"
echo "MAX_TERM $max_term"
echo "SUMW $sumW"
echo "MAX_GAP $max_gap"
echo "UPPER $upper"

lower_ok=0
upper_ok=0

if [ "$EDW" -ge "$max_term" ]; then
  lower_ok=1
fi

if [ "$EDW" -le "$upper" ]; then
  upper_ok=1
fi

if [ "$lower_ok" -eq 1 ] && [ "$upper_ok" -eq 1 ]; then
  echo "WEIGHTED_BOUNDS_OK"
  exit 0
else
  echo "WEIGHTED_BOUNDS_FAIL lower_ok=$lower_ok upper_ok=$upper_ok"
  exit 1
fi
