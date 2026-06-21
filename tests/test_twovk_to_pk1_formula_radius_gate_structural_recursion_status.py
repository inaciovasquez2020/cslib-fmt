import subprocess

def test_twovk_to_pk1_formula_radius_gate_structural_recursion_status_lock():
    result = subprocess.run(
        ["python3", "tools/verify_twovk_to_pk1_formula_radius_gate_structural_recursion_status.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TWOVK_TO_PK1_FORMULA_RADIUS_GATE_STRUCTURAL_RECURSION_STATUS_OK" in result.stdout
