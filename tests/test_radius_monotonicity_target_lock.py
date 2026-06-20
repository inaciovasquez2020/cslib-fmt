import subprocess


def test_radius_monotonicity_target_lock():
    result = subprocess.run(
        ["python3", "scripts/check_radius_monotonicity_target_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "RADIUS_MONOTONICITY_TARGET_LOCK_OK" in result.stdout
