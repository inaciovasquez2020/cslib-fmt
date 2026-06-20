#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/assignment_extension_projection_radius_control_target_shell_2026_06_20.json")
DOC = Path("docs/status/ASSIGNMENT_EXTENSION_PROJECTION_RADIUS_CONTROL_TARGET_SHELL_2026_06_20.md")
TRANSPORT = Path("artifacts/cslib_fmt/quantifier_locality_input_transport_target_shell_2026_06_20.json")
LEDGER = Path("artifacts/cslib_fmt/quantified_constructor_dependency_ledger_2026_06_20.json")

def main() -> None:
    assert TRANSPORT.exists(), TRANSPORT
    assert LEDGER.exists(), LEDGER

    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()
    ledger = json.loads(LEDGER.read_text())

    deps = ledger["required_missing_dependencies"]
    assert deps[1]["object"] == "assignment_extension_or_projection_radius_control"

    assert re.search(r"\bdef\s+assignment_extension_projection_radius_control_target_shell\b", src)
    assert re.search(r"\btheorem\s+assignment_extension_projection_radius_control_target_shell_closed\b", src)
    assert "quantifier_locality_input_transport_target_shell" in src
    assert "quantifier_locality_input_transport_target_shell_closed" in src

    assert data["artifact"] == "ASSIGNMENT_EXTENSION_PROJECTION_RADIUS_CONTROL_TARGET_SHELL"
    assert data["status"] == "TARGET_SHELL_ONLY"
    assert data["target"] == "assignment_extension_or_projection_radius_control"
    assert data["boundary"] == "BOUNDARY := ¬ assignment_extension_or_projection_radius_control"

    assert "STATUS := TARGET_SHELL_ONLY" in doc
    assert "TARGET := assignment_extension_or_projection_radius_control" in doc
    assert "BOUNDARY := ¬ assignment_extension_or_projection_radius_control" in doc

    print("ASSIGNMENT_EXTENSION_PROJECTION_RADIUS_CONTROL_TARGET_SHELL_OK")

if __name__ == "__main__":
    main()
