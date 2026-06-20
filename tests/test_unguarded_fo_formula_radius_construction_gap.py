import subprocess

def test_unguarded_fo_formula_radius_construction_gap_verifier_passes():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_formula_radius_construction_gap.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_FORMULA_RADIUS_CONSTRUCTION_GAP_OK" in result.stdout
