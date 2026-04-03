#!/usr/bin/env bash
set -euo pipefail

D=${1:-10}
C=${2:-7}

FAS=$((D - C))

if [ "$FAS" -gt 0 ]; then
  echo "FAS_POSITIVE $FAS"
  exit 1
else
  echo "FAS_NONPOSITIVE $FAS"
  exit 0
fi
