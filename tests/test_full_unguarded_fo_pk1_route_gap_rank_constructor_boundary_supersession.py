import subprocess
from pathlib import Path

PYTHON = "/opt/homebrew/Cellar/python@3.11/3.11.14_3/Frameworks/Python.framework/Versions/3.11/Resources/Python.app/Contents/MacOS/Python"

def test_full_unguarded_fo_pk1_route_gap_rank_constructor_boundary_supersession():
    result = subprocess.run(
        [PYTHON, "-B", "tools/verify_full_unguarded_fo_pk1_route_gap_rank_constructor_boundary_supersession.py"],
        cwd=Path(__file__).resolve().parents[1],
        text=True,
        capture_output=True,
        check=True,
    )
    assert "FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_CONSTRUCTOR_BOUNDARY_SUPERSESSION_OK" in result.stdout
