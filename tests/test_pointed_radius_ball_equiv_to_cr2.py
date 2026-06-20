import subprocess
import sys

def test_pointed_radius_ball_equiv_to_cr2():
    subprocess.run(
        [sys.executable, "scripts/check_pointed_radius_ball_equiv_to_cr2.py"],
        check=True,
    )
