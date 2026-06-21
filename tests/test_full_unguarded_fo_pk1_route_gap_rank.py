import subprocess
from pathlib import Path
ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
def test_full_unguarded_fo_pk1_route_gap_rank_verifier():
    result = subprocess.run(["python3", "-B", "tools/verify_full_unguarded_fo_pk1_route_gap_rank.py"], cwd=ROOT, text=True, capture_output=True, check=True)
    assert "FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_OK" in result.stdout
