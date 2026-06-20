import subprocess
import sys

def test_general_fmt_frontier_first_attack_ledger():
    subprocess.run(
        [sys.executable, "scripts/check_general_fmt_frontier_first_attack_ledger.py"],
        check=True,
    )
