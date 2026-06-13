from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def test_cslib_fmt_distance_factorization_surface_status() -> None:
    result = subprocess.run(
        [sys.executable, "tools/verify_cslib_fmt_distance_factorization_surface_status.py"],
        cwd=ROOT,
        check=True,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    assert "CSLIB_FMT_DISTANCE_FACTORIZATION_SURFACE_STATUS_OK" in result.stdout
