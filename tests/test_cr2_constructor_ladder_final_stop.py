import subprocess
import sys

def test_cr2_constructor_ladder_final_stop():
    subprocess.run(
        [sys.executable, "scripts/check_cr2_constructor_ladder_final_stop.py"],
        check=True,
    )
