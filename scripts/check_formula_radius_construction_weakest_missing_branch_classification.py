#!/usr/bin/env python3
from pathlib import Path
import json

ART = Path("artifacts/cslib_fmt/formula_radius_construction_weakest_missing_branch_classification_2026_06_20.json")
DOC = Path("docs/status/FORMULA_RADIUS_CONSTRUCTION_WEAKEST_MISSING_BRANCH_CLASSIFICATION_2026_06_20.md")

REQUIRED_INPUTS = [
    Path("artifacts/cslib_fmt/atomic_formula_radius_input_connection_status_2026_06_20.json"),
    Path("artifacts/cslib_fmt/formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate_2026_06_20.json"),
    Path("artifacts/cslib_fmt/bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface_2026_06_20.json"),
]

def main() -> None:
    for path in REQUIRED_INPUTS:
        assert path.exists(), path

    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    assert data["artifact"] == "FORMULA_RADIUS_CONSTRUCTION_WEAKEST_MISSING_BRANCH_CLASSIFICATION"
    assert data["status"] == "CLASSIFICATION_ONLY"
    assert data["weakest_missing_branch"] == "quantified_formula_radius_constructor_branch"
    assert data["boundary"] == "BOUNDARY := ¬ unguarded_fo_formula_radius_construction"

    ranked = data["ranked_gaps"]
    assert ranked[0]["rank"] == 1
    assert ranked[0]["gap"] == "quantified_formula_radius_constructor_branch"
    assert ranked[1]["gap"] == "formula_structural_recursion_assembler"
    assert ranked[2]["gap"] == "full_unguarded_fo_formula_radius_construction"

    assert "STATUS := CLASSIFICATION_ONLY" in doc
    assert "WEAKEST_MISSING_BRANCH := quantified_formula_radius_constructor_branch" in doc
    assert "BOUNDARY := ¬ unguarded_fo_formula_radius_construction" in doc
    assert "Add only a quantified formula-radius constructor target shell." in doc

    print("FORMULA_RADIUS_CONSTRUCTION_WEAKEST_MISSING_BRANCH_CLASSIFICATION_OK")

if __name__ == "__main__":
    main()
