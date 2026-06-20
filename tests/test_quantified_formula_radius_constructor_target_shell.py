import subprocess
import sys

def test_quantified_formula_radius_constructor_target_shell_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_quantified_formula_radius_constructor_target_shell.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_TARGET_SHELL_OK" in result.stdout
