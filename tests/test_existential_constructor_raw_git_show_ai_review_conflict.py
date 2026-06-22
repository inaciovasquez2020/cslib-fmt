from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_raw_git_show_ai_review_conflict() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_raw_git_show_ai_review_conflict.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_AI_REVIEW_CONFLICT_OK" in result.stdout
