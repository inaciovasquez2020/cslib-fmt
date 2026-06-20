import subprocess


def test_smaller_radius_locality_surface_weakening_lock():
    result = subprocess.run(
        ["python3", "scripts/check_smaller_radius_locality_surface_weakening_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "SMALLER_RADIUS_LOCALITY_SURFACE_WEAKENING_LOCK_OK" in result.stdout
