import subprocess
import sys

def test_common_smaller_radius_disjunction_constructor_lock_checker():
    result = subprocess.run(
        [sys.executable, "scripts/check_common_smaller_radius_disjunction_constructor_lock.py"],
        check=True,
        capture_output=True,
        text=True,
    )
    assert "COMMON_SMALLER_RADIUS_DISJUNCTION_CONSTRUCTOR_LOCK_OK" in result.stdout
