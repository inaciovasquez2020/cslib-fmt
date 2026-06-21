import subprocess
import sys

def test_quantified_formula_constructor_shape_identification_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_quantified_formula_constructor_shape_identification.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "QUANTIFIED_FORMULA_CONSTRUCTOR_SHAPE_IDENTIFICATION_OK" in result.stdout
