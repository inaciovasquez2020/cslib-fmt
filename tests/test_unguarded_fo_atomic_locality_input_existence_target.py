import subprocess

def test_unguarded_fo_atomic_locality_input_existence_target_verifier_passes():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_atomic_locality_input_existence_target.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_ATOMIC_LOCALITY_INPUT_EXISTENCE_TARGET_OK" in result.stdout
