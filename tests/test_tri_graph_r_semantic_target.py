import subprocess


def test_tri_graph_r_semantic_target_lock():
    result = subprocess.run(
        ["python3", "tools/verify_tri_graph_r_semantic_target.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TRI_GRAPH_R_SEMANTIC_TARGET_OK" in result.stdout
