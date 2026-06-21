import subprocess

def test_pk1_quantified_constructor_branch_frontier_status_lock():
    result = subprocess.run(
        ["python3", "tools/verify_pk1_quantified_constructor_branch_frontier_status.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "PK1_QUANTIFIED_CONSTRUCTOR_BRANCH_FRONTIER_STATUS_OK" in result.stdout
