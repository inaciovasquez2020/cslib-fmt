import subprocess
import sys

def test_current_strongest_cr2_input_surface_lock():
    subprocess.run(
        [sys.executable, "scripts/check_current_strongest_cr2_input_surface_lock.py"],
        check=True,
    )
