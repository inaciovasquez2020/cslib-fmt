import subprocess
import sys

def test_bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "BOUNDED_BOOLEAN_RECURSION_GATE_FROM_FINITE_BOOLEAN_FOLD_ACCESS_SURFACE_OK" in result.stdout
