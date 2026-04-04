from pathlib import Path
import json
import sys

p = Path("EXNILIO/report.json")
report = json.loads(p.read_text(encoding="utf-8"))
sys.exit(0 if report["ok"] else 1)
