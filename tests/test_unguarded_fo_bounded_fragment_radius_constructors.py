import subprocess

def test_unguarded_fo_bounded_fragment_radius_constructors_verifier_passes():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_bounded_fragment_radius_constructors.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_BOUNDED_FRAGMENT_RADIUS_CONSTRUCTORS_OK" in result.stdout
