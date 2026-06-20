import subprocess
import sys

def test_assignment_extension_projection_radius_control_statement_target_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_assignment_extension_projection_radius_control_statement_target.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "ASSIGNMENT_EXTENSION_PROJECTION_RADIUS_CONTROL_STATEMENT_TARGET_OK" in result.stdout
