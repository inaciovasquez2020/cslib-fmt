import subprocess
import sys

def test_cr2_reflexive_constructor():
    subprocess.run(
        [sys.executable, "scripts/check_cr2_reflexive_constructor.py"],
        check=True,
    )
