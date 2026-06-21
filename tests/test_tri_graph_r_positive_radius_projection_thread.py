import subprocess


def test_tri_graph_r_positive_radius_projection_thread_lock():
    result = subprocess.run(
        ["python3", "tools/verify_tri_graph_r_positive_radius_projection_thread.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TRI_GRAPH_R_POSITIVE_RADIUS_PROJECTION_THREAD_OK" in result.stdout
