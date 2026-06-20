import subprocess

def test_assignment_gaifman_close_preservation_target_classification():
    result = subprocess.run(
        ["python3", "scripts/check_assignment_gaifman_close_preservation_target_classification.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_TARGET_CLASSIFICATION_OK" in result.stdout
