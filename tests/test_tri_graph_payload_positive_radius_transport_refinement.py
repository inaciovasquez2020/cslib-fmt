import subprocess


def test_tri_graph_payload_positive_radius_transport_refinement_lock():
    result = subprocess.run(
        ["python3", "tools/verify_tri_graph_payload_positive_radius_transport_refinement.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TRI_GRAPH_PAYLOAD_POSITIVE_RADIUS_TRANSPORT_REFINEMENT_OK" in result.stdout
