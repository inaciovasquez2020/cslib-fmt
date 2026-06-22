from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_actual_downstream_theorem_use_status() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_actual_downstream_theorem_use_status.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_ACTUAL_DOWNSTREAM_THEOREM_USE_STATUS_OK" in result.stdout
