import subprocess
import sys

def test_noncomputable_audit():
    subprocess.run(
        [sys.executable, "scripts/check_noncomputable_audit.py"],
        check=True,
    )
