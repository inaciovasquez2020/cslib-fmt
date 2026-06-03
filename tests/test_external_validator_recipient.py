import subprocess
import sys

def test_external_validator_recipient():
    subprocess.run(
        [sys.executable, "tools/verify_external_validator_recipient.py"],
        check=True,
    )
