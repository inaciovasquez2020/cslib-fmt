import subprocess
import sys

def test_quantified_constructor_remaining_proof_obstruction_classification_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_quantified_constructor_remaining_proof_obstruction_classification.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "QUANTIFIED_CONSTRUCTOR_REMAINING_PROOF_OBSTRUCTION_CLASSIFICATION_OK" in result.stdout
