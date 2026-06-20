import subprocess
import sys

def test_atomic_formula_radius_input_connection_status_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_atomic_formula_radius_input_connection_status.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "ATOMIC_FORMULA_RADIUS_INPUT_CONNECTION_STATUS_OK" in result.stdout
