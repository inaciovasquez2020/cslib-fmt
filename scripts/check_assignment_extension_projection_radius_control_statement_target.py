#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/assignment_extension_projection_radius_control_statement_target_2026_06_20.json")
DOC = Path("docs/status/ASSIGNMENT_EXTENSION_PROJECTION_RADIUS_CONTROL_STATEMENT_TARGET_2026_06_20.md")
TRANSPORT_STATEMENT = Path("artifacts/cslib_fmt/concrete_quantifier_locality_input_transport_statement_target_2026_06_20.json")
ASSIGNMENT_SHELL = Path("artifacts/cslib_fmt/assignment_extension_projection_radius_control_target_shell_2026_06_20.json")
CLASSIFICATION = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_next_weakest_obstruction_classification_2026_06_20.json")

def main() -> None:
    for path in [TRANSPORT_STATEMENT, ASSIGNMENT_SHELL, CLASSIFICATION]:
        assert path.exists(), path

    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()
    classification = json.loads(CLASSIFICATION.read_text())

    ranked = classification["ranked_obstructions"]
    assert ranked[1]["object"] == "assignment_extension_projection_radius_control_statement"

    assert re.search(r"\bdef\s+assignment_extension_projection_radius_control_statement_target\b", src)
    assert re.search(r"\btheorem\s+assignment_extension_projection_radius_control_statement_target_closed\b", src)
    assert "concrete_quantifier_locality_input_transport_statement_target" in src
    assert "assignment_extension_projection_radius_control_target_shell" in src

    assert data["artifact"] == "ASSIGNMENT_EXTENSION_PROJECTION_RADIUS_CONTROL_STATEMENT_TARGET"
    assert data["status"] == "STATEMENT_TARGET_ONLY"
    assert data["ladder_position"] == "2/10"
    assert data["bounded_progress_percent"] == "20%"
    assert data["target"] == "assignment_extension_projection_radius_control_statement"
    assert data["boundary"] == "BOUNDARY := ¬ assignment_extension_projection_radius_control_statement"

    assert "STATUS := STATEMENT_TARGET_ONLY" in doc
    assert "LADDER_POSITION := 2/10" in doc
    assert "BOUNDED_PROGRESS_PERCENT := 20%" in doc
    assert "TARGET := assignment_extension_projection_radius_control_statement" in doc
    assert "BOUNDARY := ¬ assignment_extension_projection_radius_control_statement" in doc
    assert "Identify only the quantified Formula constructor shape used by this repository." in doc

    print("ASSIGNMENT_EXTENSION_PROJECTION_RADIUS_CONTROL_STATEMENT_TARGET_OK")

if __name__ == "__main__":
    main()
