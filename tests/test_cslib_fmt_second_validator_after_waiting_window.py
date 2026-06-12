from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def test_cslib_fmt_second_validator_after_waiting_window() -> None:
    result = subprocess.run(
        [sys.executable, "tools/verify_cslib_fmt_second_validator_after_waiting_window.py"],
        cwd=ROOT,
        check=True,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    assert "CSLIB_FMT_SECOND_VALIDATOR_AFTER_WAITING_WINDOW_OK" in result.stdout
