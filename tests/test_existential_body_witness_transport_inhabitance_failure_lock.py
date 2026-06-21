import subprocess
from pathlib import Path
ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
def test_existential_body_witness_transport_inhabitance_failure_lock_verifier():
    result = subprocess.run(["python3", "-B", "tools/verify_existential_body_witness_transport_inhabitance_failure_lock.py"], cwd=ROOT, text=True, capture_output=True, check=True)
    assert "EXISTENTIAL_BODY_WITNESS_TRANSPORT_INHABITANCE_FAILURE_LOCK_OK" in result.stdout
