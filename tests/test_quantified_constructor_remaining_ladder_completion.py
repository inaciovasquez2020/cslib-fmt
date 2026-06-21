import subprocess
import sys

def test_quantified_constructor_remaining_ladder_completion_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_quantified_constructor_remaining_ladder_completion.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "QUANTIFIED_CONSTRUCTOR_REMAINING_LADDER_COMPLETION_OK" in result.stdout
