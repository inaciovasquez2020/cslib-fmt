import subprocess


def test_tri_graph_name_layer_only_lock():
    result = subprocess.run(
        ["python3", "tools/verify_tri_graph_name_layer_only.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TRI_GRAPH_NAME_LAYER_ONLY_OK" in result.stdout
