import subprocess
import sys

def test_quantifier_locality_input_transport_target_shell_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_quantifier_locality_input_transport_target_shell.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "QUANTIFIER_LOCALITY_INPUT_TRANSPORT_TARGET_SHELL_OK" in result.stdout
