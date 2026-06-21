#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/quantifier_assignment_semantics_bridge_target_2026_06_21.json")
DOC = Path("docs/status/QUANTIFIER_ASSIGNMENT_SEMANTICS_BRIDGE_TARGET_2026_06_21.md")
SHAPE = Path("artifacts/cslib_fmt/quantified_formula_constructor_shape_identification_2026_06_21.json")
ASSIGNMENT = Path("artifacts/cslib_fmt/assignment_extension_projection_radius_control_statement_target_2026_06_20.json")
CLASSIFICATION = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_next_weakest_obstruction_classification_2026_06_20.json")

def main() -> None:
    for path in [SHAPE, ASSIGNMENT, CLASSIFICATION]:
        assert path.exists(), path

    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()
    classification = json.loads(CLASSIFICATION.read_text())

    ranked = classification["ranked_obstructions"]
    assert ranked[3]["object"] == "quantifier_assignment_semantics_bridge"

    assert re.search(r"\bdef\s+quantifier_assignment_semantics_bridge_target\b", src)
    assert re.search(r"\btheorem\s+quantifier_assignment_semantics_bridge_target_closed\b", src)
    assert "assignment_extension_projection_radius_control_statement_target" in src
    assert "assignment_extension_projection_radius_control_statement_target_closed" in src

    assert data["artifact"] == "QUANTIFIER_ASSIGNMENT_SEMANTICS_BRIDGE_TARGET"
    assert data["status"] == "BRIDGE_TARGET_ONLY"
    assert data["target"] == "quantifier_assignment_semantics_bridge"
    assert data["boundary"] == "BOUNDARY := ¬ quantifier_assignment_semantics_bridge"

    assert "STATUS := BRIDGE_TARGET_ONLY" in doc
    assert "TARGET := quantifier_assignment_semantics_bridge" in doc
    assert "BOUNDARY := ¬ quantifier_assignment_semantics_bridge" in doc
    assert "Add only a radius-preservation-under-quantifier-assignment-move target." in doc

    print("QUANTIFIER_ASSIGNMENT_SEMANTICS_BRIDGE_TARGET_OK")

if __name__ == "__main__":
    main()
