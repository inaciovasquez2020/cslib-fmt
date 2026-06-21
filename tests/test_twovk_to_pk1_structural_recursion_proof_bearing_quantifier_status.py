import subprocess

def test_twovk_to_pk1_structural_recursion_proof_bearing_quantifier_status_lock():
    result = subprocess.run(
        ["python3", "tools/verify_twovk_to_pk1_structural_recursion_proof_bearing_quantifier_status.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TWOVK_TO_PK1_STRUCTURAL_RECURSION_PROOF_BEARING_QUANTIFIER_STATUS_OK" in result.stdout
