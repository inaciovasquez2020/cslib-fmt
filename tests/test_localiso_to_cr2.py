import subprocess
import sys

def test_localiso_to_cr2():
    subprocess.run(
        [sys.executable, "scripts/check_localiso_to_cr2.py"],
        check=True,
    )
