import subprocess
import sys

def test_external_validation_request_packet():
    subprocess.run(
        [sys.executable, "tools/verify_external_validation_request_packet.py"],
        check=True,
    )
