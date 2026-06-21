#!/usr/bin/env python3
from pathlib import Path
import json

ART = Path("artifacts/cslib_fmt/quantified_formula_constructor_shape_identification_2026_06_21.json")
DOC = Path("docs/status/QUANTIFIED_FORMULA_CONSTRUCTOR_SHAPE_IDENTIFICATION_2026_06_21.md")
ASSIGNMENT = Path("artifacts/cslib_fmt/assignment_extension_projection_radius_control_statement_target_2026_06_20.json")
CLASSIFICATION = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_next_weakest_obstruction_classification_2026_06_20.json")

def main() -> None:
    assert ASSIGNMENT.exists(), ASSIGNMENT
    assert CLASSIFICATION.exists(), CLASSIFICATION

    data = json.loads(ART.read_text())
    doc = DOC.read_text()
    classification = json.loads(CLASSIFICATION.read_text())

    assert classification["ranked_obstructions"][2]["object"] == "quantifier_formula_constructor_shape_identification"

    assert data["artifact"] == "QUANTIFIED_FORMULA_CONSTRUCTOR_SHAPE_IDENTIFICATION"
    assert data["status"] == "IDENTIFICATION_ONLY"
    assert data["target"] == "quantifier_formula_constructor_shape_identification"
    assert data["identified_constructor_shape_candidates"]
    assert data["boundary"] == "BOUNDARY := ¬ quantified_formula_radius_constructor"

    assert "STATUS := IDENTIFICATION_ONLY" in doc
    assert "TARGET := quantifier_formula_constructor_shape_identification" in doc
    assert "BOUNDARY := ¬ quantified_formula_radius_constructor" in doc
    assert "Add only a quantifier assignment semantics bridge target." in doc

    print("QUANTIFIED_FORMULA_CONSTRUCTOR_SHAPE_IDENTIFICATION_OK")

if __name__ == "__main__":
    main()
