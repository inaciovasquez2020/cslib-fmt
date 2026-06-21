import subprocess


def test_formula_structural_recursion_positive_radius_edge_lock():
    result = subprocess.run(
        ["python3", "tools/verify_formula_structural_recursion_positive_radius_edge.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "FORMULA_STRUCTURAL_RECURSION_POSITIVE_RADIUS_EDGE_OK" in result.stdout
