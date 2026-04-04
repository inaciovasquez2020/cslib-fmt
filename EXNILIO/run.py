import sys
import subprocess
from pathlib import Path

mode = sys.argv[1] if len(sys.argv) > 1 else "quick"

steps_quick = [
    ["python3", "EXNILIO/generate.py"],
    ["python3", "EXNILIO/check.py"],
    ["python3", "EXNILIO/break.py"],
    ["python3", "EXNILIO/check.py"],
    ["python3", "EXNILIO/correct.py"],
    ["python3", "EXNILIO/check.py"],
]

steps_long = steps_quick + [
    ["python3", "EXNILIO/test_exnilio.py"],
    ["python3", "EXNILIO/check_strict.py"],
]

table = {
    "quick": steps_quick,
    "long": steps_long,
}

if mode not in table:
    raise SystemExit(f"unknown mode: {mode}")

for cmd in table[mode]:
    subprocess.run(cmd, check=False if Path(cmd[-1]).name == "check.py" else True)
