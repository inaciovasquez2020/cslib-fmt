import subprocess


def test_proof_bearing_quantifier_positive_radius_projection_edge_lock():
    result = subprocess.run(
        ["python3", "tools/verify_proof_bearing_quantifier_positive_radius_projection_edge.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "PROOF_BEARING_QUANTIFIER_POSITIVE_RADIUS_PROJECTION_EDGE_OK" in result.stdout
