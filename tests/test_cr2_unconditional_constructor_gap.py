import subprocess
import sys
def test_cr2_unconditional_constructor_gap():
    subprocess.run(
    [sys.executable, "scripts/check_cr2_unconditional_constructor_gap.py"],
    check=True,
    )
