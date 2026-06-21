import subprocess


def test_formula_radius_construction_gate_structural_recursion_edge_lock():
    result = subprocess.run(
        ["python3", "tools/verify_formula_radius_construction_gate_structural_recursion_edge.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "FORMULA_RADIUS_CONSTRUCTION_GATE_STRUCTURAL_RECURSION_EDGE_OK" in result.stdout
