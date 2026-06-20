import subprocess


def test_shared_radius_boolean_constructor_rollup_target_lock():
    result = subprocess.run(
        ["python3", "scripts/check_shared_radius_boolean_constructor_rollup_target_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "SHARED_RADIUS_BOOLEAN_CONSTRUCTOR_ROLLUP_TARGET_LOCK_OK" in result.stdout
