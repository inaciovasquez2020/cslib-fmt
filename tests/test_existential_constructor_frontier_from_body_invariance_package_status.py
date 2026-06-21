import subprocess


def test_existential_constructor_frontier_from_body_invariance_package_status():
    result = subprocess.run(
        ["python3", "-B", "tools/verify_existential_constructor_frontier_from_body_invariance_package_status.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_FRONTIER_FROM_BODY_INVARIANCE_PACKAGE_STATUS_OK" in result.stdout
