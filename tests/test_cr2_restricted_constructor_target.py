import subprocess
import sys

def test_cr2_restricted_constructor_target():
    subprocess.run(
        [sys.executable, "scripts/check_cr2_restricted_constructor_target.py"],
        check=True,
    )
