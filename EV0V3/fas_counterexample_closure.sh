#!/usr/bin/env bash
set -euo pipefail

# Counterexample Closure Test:
# Attempts to detect systems violating TIFF by hidden/global capacity
# Closure condition: no configuration where D<=C locally but failure occurs

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

# simulate hidden capacity channel
HIDDEN_SHIFT=${HIDDEN_SHIFT:-0}

all_ok=1
failure_detected=0

for i in "${!D[@]}"; do
  d=${D[i]}
  c_local=${C[i]}
  c_effective=$((c_local + HIDDEN_SHIFT))

  if [ "$d" -gt "$c_effective" ]; then
    failure_detected=1
  fi

  if [ "$d" -gt "$c_local" ]; then
    all_ok=0
  fi
done

echo "ALL_LOCAL_OK $all_ok"
echo "FAILURE_DETECTED $failure_detected"
echo "HIDDEN_SHIFT $HIDDEN_SHIFT"

# counterexample condition:
# local says OK, but global says failure OR vice versa
if [ "$all_ok" -eq 1 ] && [ "$failure_detected" -eq 1 ]; then
  echo "COUNTEREXAMPLE_FOUND"
  exit 1
else
  echo "NO_COUNTEREXAMPLE"
  exit 0
fi
