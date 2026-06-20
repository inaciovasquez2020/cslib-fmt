import subprocess
import sys

def test_finite_boolean_disjunction_fold_access_surface_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_finite_boolean_disjunction_fold_access_surface.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "FINITE_BOOLEAN_DISJUNCTION_FOLD_ACCESS_SURFACE_OK" in result.stdout
