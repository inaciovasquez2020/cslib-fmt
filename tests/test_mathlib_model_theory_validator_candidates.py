import subprocess

def test_mathlib_model_theory_validator_candidates():
    subprocess.run(
        ["python3", "tools/verify_mathlib_model_theory_validator_candidates.py"],
        check=True,
    )
