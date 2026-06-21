import subprocess


def test_existential_body_assignment_extension_invariance_component_package():
    result = subprocess.run(
        ["python3", "-B", "tools/verify_existential_body_assignment_extension_invariance_component_package.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_BODY_ASSIGNMENT_EXTENSION_INVARIANCE_COMPONENT_PACKAGE_OK" in result.stdout
