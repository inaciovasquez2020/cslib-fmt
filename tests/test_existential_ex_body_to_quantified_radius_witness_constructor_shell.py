import subprocess


def test_existential_ex_body_to_quantified_radius_witness_constructor_shell():
    result = subprocess.run(
        ["python3", "-B", "tools/verify_existential_ex_body_to_quantified_radius_witness_constructor_shell.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_SHELL_OK" in result.stdout
