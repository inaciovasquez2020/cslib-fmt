import subprocess

def test_unguarded_fo_finite_boolean_family_fold_verifier_passes():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_finite_boolean_family_fold.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_FINITE_BOOLEAN_FAMILY_FOLD_OK" in result.stdout
