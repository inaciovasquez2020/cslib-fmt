from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def test_cslib_fmt_exported_theorem_audit_lock() -> None:
    result = subprocess.run(
        [sys.executable, "tools/verify_cslib_fmt_exported_theorem_audit_lock.py"],
        cwd=ROOT,
        check=True,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    assert "CSLIB_FMT_EXPORTED_THEOREM_AUDIT_LOCK_OK" in result.stdout
