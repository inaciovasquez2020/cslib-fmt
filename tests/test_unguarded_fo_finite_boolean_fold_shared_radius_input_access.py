import subprocess

def test_unguarded_fo_finite_boolean_fold_shared_radius_input_access_verifier_passes():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_finite_boolean_fold_shared_radius_input_access.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_FINITE_BOOLEAN_FOLD_SHARED_RADIUS_INPUT_ACCESS_OK" in result.stdout
