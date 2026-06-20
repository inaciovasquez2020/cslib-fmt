import subprocess


def test_boolean_recursion_gate_after_radius_zero_atomic_connection():
    result = subprocess.run(
        ["python3", "scripts/check_boolean_recursion_gate_after_radius_zero_atomic_connection.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "BOOLEAN_RECURSION_GATE_AFTER_RADIUS_ZERO_ATOMIC_CONNECTION_OK" in result.stdout
