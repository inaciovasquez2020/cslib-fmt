import subprocess


def test_existential_body_same_witness_assignment_extension_invariance():
    result = subprocess.run(
        ["python3", "-B", "tools/verify_existential_body_same_witness_assignment_extension_invariance.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_BODY_SAME_WITNESS_ASSIGNMENT_EXTENSION_INVARIANCE_OK" in result.stdout
