#!/usr/bin/env python3
from pathlib import Path
import json

ART = Path("artifacts/cslib_fmt/quantified_constructor_dependency_ledger_2026_06_20.json")
DOC = Path("docs/status/QUANTIFIED_CONSTRUCTOR_DEPENDENCY_LEDGER_2026_06_20.md")

REQUIRED_INPUTS = [
    Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_target_shell_2026_06_20.json"),
    Path("artifacts/cslib_fmt/formula_radius_construction_weakest_missing_branch_classification_2026_06_20.json"),
    Path("artifacts/cslib_fmt/atomic_formula_radius_input_connection_status_2026_06_20.json"),
    Path("artifacts/cslib_fmt/formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate_2026_06_20.json"),
    Path("artifacts/cslib_fmt/bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface_2026_06_20.json"),
]

def main() -> None:
    for path in REQUIRED_INPUTS:
        assert path.exists(), path

    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    assert data["artifact"] == "QUANTIFIED_CONSTRUCTOR_DEPENDENCY_LEDGER"
    assert data["status"] == "DEPENDENCY_LEDGER_ONLY"
    assert data["target"] == "quantified_formula_radius_constructor_branch"
    assert data["weakest_next_dependency"] == "quantifier_locality_input_transport"
    assert data["boundary"] == "BOUNDARY := ¬ quantified_formula_radius_constructor"

    deps = data["required_missing_dependencies"]
    assert deps[0]["rank"] == 1
    assert deps[0]["object"] == "quantifier_locality_input_transport"
    assert deps[1]["object"] == "assignment_extension_or_projection_radius_control"
    assert deps[2]["object"] == "quantified_formula_radius_constructor"

    assert "STATUS := DEPENDENCY_LEDGER_ONLY" in doc
    assert "WEAKEST_NEXT_DEPENDENCY := quantifier_locality_input_transport" in doc
    assert "BOUNDARY := ¬ quantified_formula_radius_constructor" in doc
    assert "Add only a quantifier locality input transport target shell." in doc

    print("QUANTIFIED_CONSTRUCTOR_DEPENDENCY_LEDGER_OK")

if __name__ == "__main__":
    main()
