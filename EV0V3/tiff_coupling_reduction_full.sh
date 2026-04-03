#!/usr/bin/env bash
set -euo pipefail

# TIFF coupling-reduction full test
#
# Implements:
# 1) coupled capacity C*(t) = C(t) + sum_j K(t,j)
# 2) additive reduction \tilde C(t) via monotone truncation at D(t)
# 3) preservation check for violation set { t : D(t) > C*(t) }
# 4) distortion bound |ED - ED_tilde| <= epsilon
# 5) counterexample/proof witness output
#
# Usage:
#   ./tiff_coupling_reduction_full.sh d1 d2 ... -- c1 c2 ... -- k11 k12 ... k1n k21 ... knn -- epsilon
#
# Example for n=3:
#   ./tiff_coupling_reduction_full.sh \
#     5 3 8 -- \
#     4 4 4 -- \
#     0 0 1  0 0 0  0 0 0 -- \
#     0

args=("$@")
delims=()
for i in "${!args[@]}"; do
  if [ "${args[$i]}" = "--" ]; then
    delims+=("$i")
  fi
done

if [ "${#delims[@]}" -ne 3 ]; then
  echo "USAGE_ERROR expected 3 separators"
  exit 2
fi

s1=${delims[0]}
s2=${delims[1]}
s3=${delims[2]}

D=("${args[@]:0:$s1}")
C=("${args[@]:$((s1+1)):$((s2-s1-1))}")
Kflat=("${args[@]:$((s2+1)):$((s3-s2-1))}")
EPS_RAW=("${args[@]:$((s3+1))}")

if [ "${#EPS_RAW[@]}" -ne 1 ]; then
  echo "USAGE_ERROR epsilon must be a single integer"
  exit 2
fi

EPS=${EPS_RAW[0]}
n=${#D[@]}

if [ "${#C[@]}" -ne "$n" ]; then
  echo "MISMATCH_LENGTH D and C"
  exit 2
fi

if [ "${#Kflat[@]}" -ne $((n*n)) ]; then
  echo "MISMATCH_LENGTH K must be n*n"
  exit 2
fi

ED_STAR=0
ED_TILDE=0
violation_star=()
violation_tilde=()
sum_delta=0
counterexample=0

for ((i=0; i<n; i++)); do
  coupling_sum=0
  for ((j=0; j<n; j++)); do
    idx=$((i*n + j))
    coupling_sum=$((coupling_sum + Kflat[idx]))
  done

  c_star=$((C[i] + coupling_sum))

  if [ "${D[i]}" -gt "$c_star" ]; then
    violation_star+=("$i")
    e_star=$((D[i] - c_star))
  else
    e_star=0
  fi
  ED_STAR=$((ED_STAR + e_star))

  # monotone additive reduction:
  # \tilde C = min(D, C*)
  # ensures D > C*  <=>  D > \tilde C exactly when true violation exists
  if [ "$c_star" -le "${D[i]}" ]; then
    c_tilde=$c_star
  else
    c_tilde=${D[i]}
  fi

  delta_i=$((c_tilde - C[i]))
  sum_delta=$((sum_delta + delta_i))

  if [ "${D[i]}" -gt "$c_tilde" ]; then
    violation_tilde+=("$i")
    e_tilde=$((D[i] - c_tilde))
  else
    e_tilde=0
  fi
  ED_TILDE=$((ED_TILDE + e_tilde))

  echo "t=$i D=${D[i]} C=${C[i]} C_STAR=$c_star C_TILDE=$c_tilde E_STAR=$e_star E_TILDE=$e_tilde DELTA=$delta_i"
done

vstar_str="${violation_star[*]:-}"
vtilde_str="${violation_tilde[*]:-}"

echo "VIOLATION_STAR {$vstar_str}"
echo "VIOLATION_TILDE {$vtilde_str}"

if [ "$vstar_str" = "$vtilde_str" ]; then
  echo "VIOLATION_SET_PRESERVED"
  preserve=1
else
  echo "VIOLATION_SET_FAIL"
  preserve=0
  counterexample=1
fi

dist=$((ED_STAR - ED_TILDE))
if [ "$dist" -lt 0 ]; then
  dist=$(( -dist ))
fi

echo "ED_STAR $ED_STAR"
echo "ED_TILDE $ED_TILDE"
echo "DISTORTION $dist"
echo "EPSILON $EPS"

if [ "$dist" -le "$EPS" ]; then
  echo "DISTORTION_BOUND_OK"
  bound_ok=1
else
  echo "DISTORTION_BOUND_FAIL"
  bound_ok=0
  counterexample=1
fi

echo "SUM_DELTA $sum_delta"

if [ "$counterexample" -eq 1 ]; then
  echo "COUNTEREXAMPLE_FOUND"
  exit 1
fi

if [ "$preserve" -eq 1 ] && [ "$bound_ok" -eq 1 ]; then
  echo "COMPLETE_REDUCTION_PROOF_WITNESS"
  exit 0
fi

echo "INDETERMINATE"
exit 1
