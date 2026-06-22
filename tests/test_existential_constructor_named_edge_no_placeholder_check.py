from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_named_edge_no_placeholder_check() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_named_edge_no_placeholder_check.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_NAMED_EDGE_NO_PLACEHOLDER_CHECK_OK" in result.stdout
