#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_dependency_status_gate_2026_06_20.json")
DOC = Path("docs/status/QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_DEPENDENCY_STATUS_GATE_2026_06_20.md")
ASSIGNMENT = Path("artifacts/cslib_fmt/assignment_extension_projection_radius_control_target_shell_2026_06_20.json")
TRANSPORT = Path("artifacts/cslib_fmt/quantifier_locality_input_transport_target_shell_2026_06_20.json")
LEDGER = Path("artifacts/cslib_fmt/quantified_constructor_dependency_ledger_2026_06_20.json")
TARGET = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_target_shell_2026_06_20.json")

def main() -> None:
    for path in [ASSIGNMENT, TRANSPORT, LEDGER, TARGET]:
        assert path.exists(), path

    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()
    ledger = json.loads(LEDGER.read_text())

    deps = [item["object"] for item in ledger["required_missing_dependencies"]]
    assert "quantifier_locality_input_transport" in deps
    assert "assignment_extension_or_projection_radius_control" in deps
    assert "quantified_formula_radius_constructor" in deps

    assert re.search(r"\bdef\s+quantified_formula_radius_constructor_dependency_status_gate\b", src)
    assert re.search(r"\btheorem\s+quantified_formula_radius_constructor_dependency_status_gate_closed\b", src)
    assert "assignment_extension_projection_radius_control_target_shell" in src
    assert "assignment_extension_projection_radius_control_target_shell_closed" in src
    assert "quantifier_locality_input_transport_target_shell" in src
    assert "quantified_formula_radius_constructor_target_shell" in src

    assert data["artifact"] == "QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_DEPENDENCY_STATUS_GATE"
    assert data["status"] == "DEPENDENCY_STATUS_GATE_ONLY"
    assert data["target"] == "quantified_formula_radius_constructor"
    assert data["boundary"] == "BOUNDARY := ¬ quantified_formula_radius_constructor"
    assert "quantifier_locality_input_transport_target_shell" in data["closed_dependency_targets"]
    assert "assignment_extension_projection_radius_control_target_shell" in data["closed_dependency_targets"]

    assert "STATUS := DEPENDENCY_STATUS_GATE_ONLY" in doc
    assert "TARGET := quantified_formula_radius_constructor" in doc
    assert "BOUNDARY := ¬ quantified_formula_radius_constructor" in doc
    assert "Classify the next weakest obstruction to proving quantified_formula_radius_constructor." in doc

    print("QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_DEPENDENCY_STATUS_GATE_OK")

if __name__ == "__main__":
    main()
