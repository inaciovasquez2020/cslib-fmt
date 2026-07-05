import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def test_zero_one_law_structural_solve_receipt_verifier():
    result = subprocess.run(
        ["python3", "tools/verify_zero_one_law_structural_solve_receipt.py"],
        cwd=ROOT,
        text=True,
        capture_output=True,
        check=True,
    )
    assert "ZERO_ONE_LAW_STRUCTURAL_SOLVE_RECEIPT_OK" in result.stdout
