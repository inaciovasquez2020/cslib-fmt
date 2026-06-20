import subprocess

def test_unguarded_fo_shared_radius_family_introductions_verifier_passes():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_shared_radius_family_introductions.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_SHARED_RADIUS_FAMILY_INTRODUCTIONS_OK" in result.stdout
