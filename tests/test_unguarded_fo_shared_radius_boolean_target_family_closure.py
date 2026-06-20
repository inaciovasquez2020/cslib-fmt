import subprocess

def test_unguarded_fo_shared_radius_boolean_target_family_closure_verifier_passes():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_shared_radius_boolean_target_family_closure.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_SHARED_RADIUS_BOOLEAN_TARGET_FAMILY_CLOSURE_OK" in result.stdout
