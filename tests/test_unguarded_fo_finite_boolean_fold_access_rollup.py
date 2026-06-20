import subprocess

def test_unguarded_fo_finite_boolean_fold_access_rollup_verifier_passes():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_finite_boolean_fold_access_rollup.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_FINITE_BOOLEAN_FOLD_ACCESS_ROLLUP_OK" in result.stdout
