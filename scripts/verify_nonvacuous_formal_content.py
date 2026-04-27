#!/usr/bin/env python3
from pathlib import Path
import re
import subprocess
import sys

lean = Path("CslibFmt/FormalContent/NonVacuousCore.lean")
status = Path("docs/status/NONVACUOUS_FORMAL_CONTENT_2026_04_27.md")

if not lean.exists():
    raise SystemExit("missing Lean formal-content file")
if not status.exists():
    raise SystemExit("missing status lock")

text = lean.read_text(encoding="utf-8")
status_text = status.read_text(encoding="utf-8")

required_theorems = [
    "theorem nat_add_comm_core",
    "theorem nat_add_assoc_core",
    "theorem nat_add_right_cancel_core",
]

for needle in required_theorems:
    if needle not in text:
        raise SystemExit(f"missing theorem: {needle}")

for forbidden in [r"\baxiom\b", r"\bsorry\b", r"\badmit\b", r":=\s*True\b", r":\s*True\s*:="]:
    if re.search(forbidden, text):
        raise SystemExit(f"forbidden vacuity marker present: {forbidden}")

required_status = [
    "formal-content increment",
    "not a major theorem claim",
    "This does not claim external validation or theorem-level closure of any large conjecture.",
    "small nonvacuous Lean support-library increment",
]

for needle in required_status:
    if needle not in status_text:
        raise SystemExit(f"missing status phrase: {needle}")

cmd = [sys.executable, "-m", "py_compile", __file__]
subprocess.run(cmd, check=True)

lean_cmd = ["lake", "env", "lean", str(lean)]
fallback_cmd = ["lean", str(lean)]

try:
    subprocess.run(lean_cmd, check=True)
except FileNotFoundError:
    subprocess.run(fallback_cmd, check=True)

print("nonvacuous formal content: PASS")
