from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_live_repo_review_request_after_machine_grep() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_live_repo_review_request_after_machine_grep.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_LIVE_REPO_REVIEW_REQUEST_AFTER_MACHINE_GREP_OK" in result.stdout
