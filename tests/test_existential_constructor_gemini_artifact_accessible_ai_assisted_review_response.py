from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_gemini_artifact_accessible_ai_assisted_review_response() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_gemini_artifact_accessible_ai_assisted_review_response.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_GEMINI_ARTIFACT_ACCESSIBLE_AI_ASSISTED_REVIEW_RESPONSE_OK" in result.stdout
