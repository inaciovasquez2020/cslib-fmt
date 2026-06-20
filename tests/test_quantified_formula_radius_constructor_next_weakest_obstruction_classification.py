import subprocess
import sys

def test_quantified_formula_radius_constructor_next_weakest_obstruction_classification_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_quantified_formula_radius_constructor_next_weakest_obstruction_classification.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_NEXT_WEAKEST_OBSTRUCTION_CLASSIFICATION_OK" in result.stdout
