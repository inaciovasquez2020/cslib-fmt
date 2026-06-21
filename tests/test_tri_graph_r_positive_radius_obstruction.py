import subprocess


def test_tri_graph_r_positive_radius_obstruction_lock():
    result = subprocess.run(
        ["python3", "tools/verify_tri_graph_r_positive_radius_obstruction.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TRI_GRAPH_R_POSITIVE_RADIUS_OBSTRUCTION_OK" in result.stdout
