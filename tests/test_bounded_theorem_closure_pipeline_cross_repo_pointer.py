import subprocess


def test_bounded_theorem_closure_pipeline_cross_repo_pointer():
    completed = subprocess.run(
        ["python3", "tools/verify_bounded_theorem_closure_pipeline_cross_repo_pointer.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "BOUNDED_THEOREM_CLOSURE_PIPELINE_CROSS_REPO_POINTER_OK" in completed.stdout
