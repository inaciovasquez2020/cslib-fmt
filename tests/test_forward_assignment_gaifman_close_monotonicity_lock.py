import subprocess


def test_forward_assignment_gaifman_close_monotonicity_lock():
    result = subprocess.run(
        ["python3", "scripts/check_forward_assignment_gaifman_close_monotonicity_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "FORWARD_ASSIGNMENT_GAIFMAN_CLOSE_MONOTONICITY_LOCK_OK" in result.stdout
