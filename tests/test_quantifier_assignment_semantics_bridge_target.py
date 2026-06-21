import subprocess
import sys

def test_quantifier_assignment_semantics_bridge_target_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_quantifier_assignment_semantics_bridge_target.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "QUANTIFIER_ASSIGNMENT_SEMANTICS_BRIDGE_TARGET_OK" in result.stdout
