import subprocess
import sys

def test_cr2_exact_target_surface():
    subprocess.run(
        [sys.executable, "scripts/check_cr2_exact_target_surface.py"],
        check=True,
    )
