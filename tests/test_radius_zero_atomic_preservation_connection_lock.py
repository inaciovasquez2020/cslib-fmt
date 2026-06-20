import subprocess


def test_radius_zero_atomic_preservation_connection_lock():
    result = subprocess.run(
        ["python3", "scripts/check_radius_zero_atomic_preservation_connection_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "RADIUS_ZERO_ATOMIC_PRESERVATION_CONNECTION_LOCK_OK" in result.stdout
