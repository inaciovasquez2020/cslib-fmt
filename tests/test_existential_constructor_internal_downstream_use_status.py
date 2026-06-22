from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_internal_downstream_use_status() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_internal_downstream_use_status.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_INTERNAL_DOWNSTREAM_USE_STATUS_OK" in result.stdout
