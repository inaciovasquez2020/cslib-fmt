import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def test_zero_one_law_followup_receipts_verifier():
    result = subprocess.run(
        ["python3", "tools/verify_zero_one_law_followup_receipts.py"],
        cwd=ROOT,
        text=True,
        capture_output=True,
        check=True,
    )
    assert "ZERO_ONE_LAW_FOLLOWUP_RECEIPTS_OK" in result.stdout
