import subprocess


def test_assignment_gaifman_close_monotonicity_target_lock():
    result = subprocess.run(
        ["python3", "scripts/check_assignment_gaifman_close_monotonicity_target_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "ASSIGNMENT_GAIFMAN_CLOSE_MONOTONICITY_TARGET_LOCK_OK" in result.stdout
