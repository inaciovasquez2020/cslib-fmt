import subprocess
import sys

def test_external_validation_request_sent():
    subprocess.run(
        [sys.executable, "tools/verify_external_validation_request_sent.py"],
        check=True,
    )
