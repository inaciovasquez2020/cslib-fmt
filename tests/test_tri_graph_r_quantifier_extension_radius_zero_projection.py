import subprocess


def test_tri_graph_r_quantifier_extension_radius_zero_projection_lock():
    result = subprocess.run(
        ["python3", "tools/verify_tri_graph_r_quantifier_extension_radius_zero_projection.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TRI_GRAPH_R_QUANTIFIER_EXTENSION_RADIUS_ZERO_PROJECTION_OK" in result.stdout
