from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def test_existential_constructor_external_validation_request_packet() -> None:
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [sys.executable, "tools/verify_existential_constructor_external_validation_request_packet.py"],
        cwd=root,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_VALIDATION_REQUEST_PACKET_OK" in result.stdout
