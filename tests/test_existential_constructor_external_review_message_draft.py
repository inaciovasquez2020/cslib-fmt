from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_external_review_message_draft() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_external_review_message_draft.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_REVIEW_MESSAGE_DRAFT_OK" in result.stdout
