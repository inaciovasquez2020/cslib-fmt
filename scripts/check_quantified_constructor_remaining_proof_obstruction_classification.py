#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/quantified_constructor_remaining_proof_obstruction_classification_2026_06_21.json")
DOC = Path("docs/status/QUANTIFIED_CONSTRUCTOR_REMAINING_PROOF_OBSTRUCTION_CLASSIFICATION_2026_06_21.md")
LADDER = Path("artifacts/cslib_fmt/quantified_constructor_remaining_ladder_completion_2026_06_21.json")

TARGETS = [
    "quantifier_assignment_semantics_bridge_target",
    "radius_preservation_under_quantifier_assignment_move_target",
    "locality_surface_transport_body_to_quantified_formula_target",
    "existential_quantifier_constructor_branch_target",
    "universal_quantifier_constructor_branch_classification_target",
    "quantified_formula_radius_constructor_target_status",
    "formula_structural_recursion_assembler_target",
]

EXPECTED = [
    "proof_bearing_quantifier_assignment_radius_control_statement",
    "proof_bearing_quantifier_locality_input_transport",
    "existential_quantifier_formula_radius_constructor_proof",
    "universal_quantifier_formula_radius_constructor_classification_or_proof",
    "quantified_formula_radius_constructor_proof",
    "formula_structural_recursion_assembler_proof",
]

def main() -> None:
    assert LADDER.exists(), LADDER

    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    for target in TARGETS:
        assert re.search(rf"\bdef\s+{target}\b", src), target
        assert re.search(rf"\btheorem\s+{target}_closed\b", src), target

    assert data["artifact"] == "QUANTIFIED_CONSTRUCTOR_REMAINING_PROOF_OBSTRUCTION_CLASSIFICATION"
    assert data["status"] == "CLASSIFICATION_ONLY"
    assert data["weakest_remaining_proof_obstruction"] == "proof_bearing_quantifier_assignment_radius_control_statement"
    assert data["boundary"] == "BOUNDARY := ¬ unguarded_fo_formula_radius_construction"

    ranked = data["ranked_remaining_proof_obstructions"]
    assert len(ranked) == 6
    for index, name in enumerate(EXPECTED, start=1):
        assert ranked[index - 1]["rank"] == index
        assert ranked[index - 1]["object"] == name

    assert "STATUS := CLASSIFICATION_ONLY" in doc
    assert "WEAKEST_REMAINING_PROOF_OBSTRUCTION := proof_bearing_quantifier_assignment_radius_control_statement" in doc
    assert "BOUNDARY := ¬ unguarded_fo_formula_radius_construction" in doc
    assert "Add only a proof-bearing quantifier assignment radius-control statement target." in doc

    print("QUANTIFIED_CONSTRUCTOR_REMAINING_PROOF_OBSTRUCTION_CLASSIFICATION_OK")

if __name__ == "__main__":
    main()
