import subprocess
import sys

def test_plain_induced_radius_ball_isomorphism_to_cr2():
    subprocess.run(
        [sys.executable, "scripts/check_plain_induced_radius_ball_isomorphism_to_cr2.py"],
        check=True,
    )
