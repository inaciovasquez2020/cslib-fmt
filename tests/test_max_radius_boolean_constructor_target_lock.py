import subprocess


def test_max_radius_boolean_constructor_target_lock():
    result = subprocess.run(
        ["python3", "scripts/check_max_radius_boolean_constructor_target_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "MAX_RADIUS_BOOLEAN_CONSTRUCTOR_TARGET_LOCK_OK" in result.stdout
