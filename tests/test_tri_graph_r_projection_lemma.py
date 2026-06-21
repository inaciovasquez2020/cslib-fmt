import subprocess


def test_tri_graph_r_projection_lemma_lock():
    result = subprocess.run(
        ["python3", "tools/verify_tri_graph_r_projection_lemma.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TRI_GRAPH_R_PROJECTION_LEMMA_OK" in result.stdout
