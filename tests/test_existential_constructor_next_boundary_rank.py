from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_next_boundary_rank() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_next_boundary_rank.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_NEXT_BOUNDARY_RANK_OK" in result.stdout
