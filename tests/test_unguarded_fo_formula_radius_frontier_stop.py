import subprocess

def test_unguarded_fo_formula_radius_frontier_stop_verifier_passes():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_formula_radius_frontier_stop.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_FORMULA_RADIUS_FRONTIER_STOP_OK" in result.stdout
