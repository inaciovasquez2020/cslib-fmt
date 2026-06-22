from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_independent_review_response_pending_status() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_independent_review_response_pending_status.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_INDEPENDENT_REVIEW_RESPONSE_PENDING_STATUS_OK" in result.stdout
