#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/concrete_quantifier_locality_input_transport_statement_target_2026_06_20.json")
DOC = Path("docs/status/CONCRETE_QUANTIFIER_LOCALITY_INPUT_TRANSPORT_STATEMENT_TARGET_2026_06_20.md")
CLASSIFICATION = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_next_weakest_obstruction_classification_2026_06_20.json")
GATE = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_dependency_status_gate_2026_06_20.json")
TRANSPORT = Path("artifacts/cslib_fmt/quantifier_locality_input_transport_target_shell_2026_06_20.json")

def main() -> None:
    for path in [CLASSIFICATION, GATE, TRANSPORT]:
        assert path.exists(), path

    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()
    classification = json.loads(CLASSIFICATION.read_text())

    assert classification["weakest_next_obstruction"] == "concrete_quantifier_locality_input_transport_statement"

    assert re.search(r"\bdef\s+concrete_quantifier_locality_input_transport_statement_target\b", src)
    assert re.search(r"\btheorem\s+concrete_quantifier_locality_input_transport_statement_target_closed\b", src)
    assert "quantified_formula_radius_constructor_dependency_status_gate" in src
    assert "quantified_formula_radius_constructor_dependency_status_gate_closed" in src
    assert "quantifier_locality_input_transport_target_shell" in src

    assert data["artifact"] == "CONCRETE_QUANTIFIER_LOCALITY_INPUT_TRANSPORT_STATEMENT_TARGET"
    assert data["status"] == "STATEMENT_TARGET_ONLY"
    assert data["target"] == "concrete_quantifier_locality_input_transport_statement"
    assert data["boundary"] == "BOUNDARY := ¬ concrete_quantifier_locality_input_transport_statement"

    assert "STATUS := STATEMENT_TARGET_ONLY" in doc
    assert "TARGET := concrete_quantifier_locality_input_transport_statement" in doc
    assert "BOUNDARY := ¬ concrete_quantifier_locality_input_transport_statement" in doc
    assert "Add only an assignment extension/projection radius-control statement target." in doc

    print("CONCRETE_QUANTIFIER_LOCALITY_INPUT_TRANSPORT_STATEMENT_TARGET_OK")

if __name__ == "__main__":
    main()
