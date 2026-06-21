import subprocess
from pathlib import Path
ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
def test_existential_body_witness_locality_transport_type_shell_verifier():
    result = subprocess.run(["python3", "-B", "tools/verify_existential_body_witness_locality_transport_type_shell.py"], cwd=ROOT, text=True, capture_output=True, check=True)
    assert "EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_TYPE_SHELL_OK" in result.stdout
