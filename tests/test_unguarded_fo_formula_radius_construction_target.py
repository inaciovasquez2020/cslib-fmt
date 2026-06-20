import subprocess
import sys

def test_unguarded_fo_formula_radius_construction_target():
    subprocess.run(
        [sys.executable, "scripts/check_unguarded_fo_formula_radius_construction_target.py"],
        check=True,
    )
