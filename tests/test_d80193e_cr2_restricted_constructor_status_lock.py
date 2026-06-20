import subprocess
import sys

def test_d80193e_cr2_restricted_constructor_status_lock():
    subprocess.run(
        [sys.executable, "scripts/check_d80193e_cr2_restricted_constructor_status_lock.py"],
        check=True,
    )
