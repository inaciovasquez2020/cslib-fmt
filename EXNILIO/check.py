from pathlib import Path
import json
import sys

p = Path("EXNILIO/input.txt")
xs = p.read_text(encoding="utf-8").splitlines()

trimmed = [x == x.strip() for x in xs]
nonempty = [x != "" for x in xs]
unique = len(xs) == len(set(xs))
sorted_ok = xs == sorted(xs)

report = {
    "lines": xs,
    "count": len(xs),
    "nonempty": all(nonempty),
    "trimmed": all(trimmed),
    "unique": unique,
    "sorted": sorted_ok,
    "ok": all(nonempty) and all(trimmed) and unique and sorted_ok
}

Path("EXNILIO/report.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
print(json.dumps(report, indent=2))
sys.exit(0 if report["ok"] else 1)
