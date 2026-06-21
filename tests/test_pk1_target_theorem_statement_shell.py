import subprocess

def test_pk1_target_theorem_statement_shell_lock():
    result = subprocess.run(
        ["python3", "tools/verify_pk1_target_theorem_statement_shell.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "PK1_TARGET_THEOREM_STATEMENT_SHELL_OK" in result.stdout
