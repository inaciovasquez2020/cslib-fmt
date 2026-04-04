import json
import subprocess
from pathlib import Path

subprocess.run(["bash", "EXNILIO/run.sh"], check=True)

report = json.loads(Path("EXNILIO/report.json").read_text(encoding="utf-8"))
assert report["ok"] is True
assert report["lines"] == ["alpha", "beta", "gamma"]
