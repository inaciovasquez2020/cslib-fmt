from __future__ import annotations

import pathlib
import subprocess


def test_cslib_downstream_library_entrypoint_readiness_verifier() -> None:
    root = pathlib.Path(__file__).resolve().parents[1]
    verifier = root / "tools" / "verify_cslib_downstream_library_entrypoint_readiness_2026_06_25.py"
    result = subprocess.run(
        ["python3", str(verifier)],
        cwd=root,
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    assert "CSLIB_DOWNSTREAM_LIBRARY_ENTRYPOINT_READINESS_2026_06_25_OK" in result.stdout
