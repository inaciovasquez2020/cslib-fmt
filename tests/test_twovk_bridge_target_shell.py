import subprocess

def test_twovk_bridge_target_shell_lock():
    result = subprocess.run(
        ["python3", "tools/verify_twovk_bridge_target_shell.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "TWOVK_BRIDGE_TARGET_SHELL_OK" in result.stdout
