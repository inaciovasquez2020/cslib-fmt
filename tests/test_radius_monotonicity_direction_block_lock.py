import subprocess


def test_radius_monotonicity_direction_block_lock():
    result = subprocess.run(
        ["python3", "scripts/check_radius_monotonicity_direction_block_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "RADIUS_MONOTONICITY_DIRECTION_BLOCK_LOCK_OK" in result.stdout
