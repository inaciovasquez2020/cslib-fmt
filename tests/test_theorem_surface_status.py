import subprocess
import sys

def test_theorem_surface_status_guard_passes():
    subprocess.run(
        [sys.executable, "scripts/check_theorem_surface_status.py"],
        check=True,
    )
