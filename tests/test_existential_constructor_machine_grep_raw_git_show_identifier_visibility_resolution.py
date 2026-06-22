from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_machine_grep_raw_git_show_identifier_visibility_resolution() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_machine_grep_raw_git_show_identifier_visibility_resolution.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_MACHINE_GREP_RAW_GIT_SHOW_IDENTIFIER_VISIBILITY_RESOLUTION_OK" in result.stdout
