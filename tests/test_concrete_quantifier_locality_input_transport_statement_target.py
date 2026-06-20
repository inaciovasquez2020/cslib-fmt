import subprocess
import sys

def test_concrete_quantifier_locality_input_transport_statement_target_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_concrete_quantifier_locality_input_transport_statement_target.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "CONCRETE_QUANTIFIER_LOCALITY_INPUT_TRANSPORT_STATEMENT_TARGET_OK" in result.stdout
