import subprocess
import sys

def test_formula_radius_construction_weakest_missing_branch_classification_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_formula_radius_construction_weakest_missing_branch_classification.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "FORMULA_RADIUS_CONSTRUCTION_WEAKEST_MISSING_BRANCH_CLASSIFICATION_OK" in result.stdout
