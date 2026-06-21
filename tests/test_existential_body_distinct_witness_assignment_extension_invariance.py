import subprocess


def test_existential_body_distinct_witness_assignment_extension_invariance():
    result = subprocess.run(
        ["python3", "-B", "tools/verify_existential_body_distinct_witness_assignment_extension_invariance.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_BODY_DISTINCT_WITNESS_ASSIGNMENT_EXTENSION_INVARIANCE_OK" in result.stdout
