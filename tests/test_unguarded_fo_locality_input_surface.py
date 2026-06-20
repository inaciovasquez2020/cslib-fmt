import subprocess
import sys

def test_unguarded_fo_locality_input_surface():
    subprocess.run(
        [sys.executable, "scripts/check_unguarded_fo_locality_input_surface.py"],
        check=True,
    )
