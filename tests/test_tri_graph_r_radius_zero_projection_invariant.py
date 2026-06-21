import subprocess


def test_tri_graph_r_radius_zero_projection_invariant_lock():
    result = subprocess.run(
        ["python3", "tools/verify_tri_graph_r_radius_zero_projection_invariant.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TRI_GRAPH_R_RADIUS_ZERO_PROJECTION_INVARIANT_OK" in result.stdout
