#!/usr/bin/env bash
set -euo pipefail
MODE="${1:-quick}"
python3 EXNILIO/run.py "$MODE"
