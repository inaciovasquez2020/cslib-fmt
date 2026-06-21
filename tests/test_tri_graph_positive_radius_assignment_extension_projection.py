import subprocess


def test_tri_graph_positive_radius_assignment_extension_projection_lock():
    result = subprocess.run(
        ["python3", "tools/verify_tri_graph_positive_radius_assignment_extension_projection.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TRI_GRAPH_POSITIVE_RADIUS_ASSIGNMENT_EXTENSION_PROJECTION_OK" in result.stdout
