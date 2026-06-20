#!/usr/bin/env python3
from pathlib import Path
import json

ART = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_next_weakest_obstruction_classification_2026_06_20.json")
DOC = Path("docs/status/QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_NEXT_WEAKEST_OBSTRUCTION_CLASSIFICATION_2026_06_20.md")

REQUIRED_INPUTS = [
    Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_dependency_status_gate_2026_06_20.json"),
    Path("artifacts/cslib_fmt/assignment_extension_projection_radius_control_target_shell_2026_06_20.json"),
    Path("artifacts/cslib_fmt/quantifier_locality_input_transport_target_shell_2026_06_20.json"),
    Path("artifacts/cslib_fmt/quantified_constructor_dependency_ledger_2026_06_20.json"),
    Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_target_shell_2026_06_20.json"),
]

EXPECTED = [
    "concrete_quantifier_locality_input_transport_statement",
    "assignment_extension_projection_radius_control_statement",
    "quantifier_formula_constructor_shape_identification",
    "quantifier_assignment_semantics_bridge",
    "radius_preservation_under_quantifier_assignment_move",
    "locality_surface_transport_from_body_to_quantified_formula",
    "existential_quantifier_constructor_branch",
    "universal_quantifier_constructor_branch",
    "quantified_formula_radius_constructor",
    "formula_structural_recursion_assembler",
]

def main() -> None:
    for path in REQUIRED_INPUTS:
        assert path.exists(), path

    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    assert data["artifact"] == "QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_NEXT_WEAKEST_OBSTRUCTION_CLASSIFICATION"
    assert data["status"] == "CLASSIFICATION_ONLY"
    assert data["target"] == "quantified_formula_radius_constructor"
    assert data["weakest_next_obstruction"] == "concrete_quantifier_locality_input_transport_statement"
    assert data["boundary"] == "BOUNDARY := ¬ quantified_formula_radius_constructor"

    ranked = data["ranked_obstructions"]
    assert len(ranked) == 10
    for index, name in enumerate(EXPECTED, start=1):
        assert ranked[index - 1]["rank"] == index
        assert ranked[index - 1]["object"] == name

    assert "STATUS := CLASSIFICATION_ONLY" in doc
    assert "WEAKEST_NEXT_OBSTRUCTION := concrete_quantifier_locality_input_transport_statement" in doc
    assert "BOUNDARY := ¬ quantified_formula_radius_constructor" in doc
    assert "10. formula_structural_recursion_assembler" in doc
    assert "Add only a concrete quantifier locality input transport statement target." in doc

    print("QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_NEXT_WEAKEST_OBSTRUCTION_CLASSIFICATION_OK")

if __name__ == "__main__":
    main()
