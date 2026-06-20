import subprocess
import sys

def test_restricted_guarded_local_type_equivalent_to_cr2():
    subprocess.run(
        [sys.executable, "scripts/check_restricted_guarded_local_type_equivalent_to_cr2.py"],
        check=True,
    )
