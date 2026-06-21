import subprocess

def test_twovk_to_pk1_quantified_constructor_frontier_status_lock():
    result = subprocess.run(
        ["python3", "tools/verify_twovk_to_pk1_quantified_constructor_frontier_status.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TWOVK_TO_PK1_QUANTIFIED_CONSTRUCTOR_FRONTIER_STATUS_OK" in result.stdout
