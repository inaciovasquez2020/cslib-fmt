import subprocess
import sys

def test_quantified_constructor_dependency_ledger_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_quantified_constructor_dependency_ledger.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "QUANTIFIED_CONSTRUCTOR_DEPENDENCY_LEDGER_OK" in result.stdout
