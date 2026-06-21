import subprocess
from pathlib import Path

ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())

def test_existential_ex_body_to_quantified_radius_witness_constructor_stopping_point_verifier():
    result = subprocess.run(
        ["python3", "-B", "tools/verify_existential_ex_body_to_quantified_radius_witness_constructor_stopping_point.py"],
        cwd=ROOT,
        text=True,
        capture_output=True,
        check=True,
    )
    assert "EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_OK" in result.stdout
