#!/usr/bin/env bash
set -euo pipefail
python3 EXNILIO/generate.py
python3 EXNILIO/check.py || true
python3 EXNILIO/break.py
python3 EXNILIO/check.py || true
python3 EXNILIO/correct.py
python3 EXNILIO/check.py
