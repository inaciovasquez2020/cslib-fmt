import subprocess
from pathlib import Path
ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
def test_existential_locality_radius_constructor_missing_theorem_status_verifier():
    result = subprocess.run(["python3", "-B", "tools/verify_existential_locality_radius_constructor_missing_theorem_status.py"], cwd=ROOT, text=True, capture_output=True, check=True)
    assert "EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_MISSING_THEOREM_STATUS_OK" in result.stdout
