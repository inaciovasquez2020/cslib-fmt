import subprocess
import sys

def test_no_external_below_localiso_constructor_source():
    subprocess.run(
        [sys.executable, "scripts/check_no_external_below_localiso_constructor_source.py"],
        check=True,
    )
