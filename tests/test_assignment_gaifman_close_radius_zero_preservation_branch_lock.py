import subprocess


def test_assignment_gaifman_close_radius_zero_preservation_branch_lock():
    result = subprocess.run(
        ["python3", "scripts/check_assignment_gaifman_close_radius_zero_preservation_branch_lock.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "ASSIGNMENT_GAIFMAN_CLOSE_RADIUS_ZERO_PRESERVATION_BRANCH_LOCK_OK" in result.stdout
