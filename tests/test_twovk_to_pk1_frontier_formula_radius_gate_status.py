import subprocess

def test_twovk_to_pk1_frontier_formula_radius_gate_status_lock():
    result = subprocess.run(
        ["python3", "tools/verify_twovk_to_pk1_frontier_formula_radius_gate_status.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TWOVK_TO_PK1_FRONTIER_FORMULA_RADIUS_GATE_STATUS_OK" in result.stdout
