import subprocess
import sys

def test_formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "FORMULA_RADIUS_CONSTRUCTION_GATE_STATUS_FROM_BOUNDED_BOOLEAN_RECURSION_GATE_OK" in result.stdout
