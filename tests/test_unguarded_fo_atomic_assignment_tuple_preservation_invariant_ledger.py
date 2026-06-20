import subprocess

def test_unguarded_fo_atomic_assignment_tuple_preservation_invariant_ledger():
    result = subprocess.run(
        ["python3", "scripts/check_unguarded_fo_atomic_assignment_tuple_preservation_invariant_ledger.py"],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "UNGUARDED_FO_ATOMIC_ASSIGNMENT_TUPLE_PRESERVATION_INVARIANT_LEDGER_OK" in result.stdout
