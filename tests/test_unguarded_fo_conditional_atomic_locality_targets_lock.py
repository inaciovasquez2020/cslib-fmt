import subprocess

def test_unguarded_fo_conditional_atomic_locality_targets_lock():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_conditional_atomic_locality_targets_lock.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_CONDITIONAL_ATOMIC_LOCALITY_TARGETS_LOCK_OK" in result.stdout
