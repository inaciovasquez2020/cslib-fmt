import subprocess


def test_bounded_boolean_radius_zero_constructor_target_lock():
    result = subprocess.run(
        ["python3", "scripts/check_bounded_boolean_radius_zero_constructor_target_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "BOUNDED_BOOLEAN_RADIUS_ZERO_CONSTRUCTOR_TARGET_LOCK_OK" in result.stdout
