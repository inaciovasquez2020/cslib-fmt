import subprocess

def test_assignment_gaifman_close_preservation_target_lock():
    result = subprocess.run(
        ["python3", "scripts/check_assignment_gaifman_close_preservation_target_lock.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_TARGET_LOCK_OK" in result.stdout
