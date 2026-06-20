import subprocess


def test_unguarded_fo_conj_same_radius_constructor_lock():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_conj_same_radius_constructor_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "UNGUARDED_FO_CONJ_SAME_RADIUS_CONSTRUCTOR_LOCK_OK" in result.stdout
