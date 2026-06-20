import subprocess
import sys

def test_quantified_formula_radius_constructor_dependency_status_gate_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_quantified_formula_radius_constructor_dependency_status_gate.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_DEPENDENCY_STATUS_GATE_OK" in result.stdout
