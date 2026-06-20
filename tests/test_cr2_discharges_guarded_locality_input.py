import subprocess
import sys

def test_cr2_discharges_guarded_locality_input():
    subprocess.run(
        [sys.executable, "scripts/check_cr2_discharges_guarded_locality_input.py"],
        check=True,
    )
