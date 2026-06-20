import subprocess
import sys

def test_assignment_extension_projection_radius_control_target_shell_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_assignment_extension_projection_radius_control_target_shell.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "ASSIGNMENT_EXTENSION_PROJECTION_RADIUS_CONTROL_TARGET_SHELL_OK" in result.stdout
