#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/quantified_constructor_remaining_ladder_completion_2026_06_21.json")
DOC = Path("docs/status/QUANTIFIED_CONSTRUCTOR_REMAINING_LADDER_COMPLETION_2026_06_21.md")

TARGETS = [
    "quantifier_assignment_semantics_bridge_target",
    "radius_preservation_under_quantifier_assignment_move_target",
    "locality_surface_transport_body_to_quantified_formula_target",
    "existential_quantifier_constructor_branch_target",
    "universal_quantifier_constructor_branch_classification_target",
    "quantified_formula_radius_constructor_target_status",
    "formula_structural_recursion_assembler_target",
]

def main() -> None:
    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    assert data["artifact"] == "QUANTIFIED_CONSTRUCTOR_REMAINING_LADDER_COMPLETION"
    assert data["status"] == "TARGET_LADDER_COMPLETION_ONLY"
    assert data["completed_targets"] == TARGETS
    assert data["boundary"] == "BOUNDARY := ¬ unguarded_fo_formula_radius_construction"

    for target in TARGETS:
        assert re.search(rf"\bdef\s+{target}\b", src), target
        assert re.search(rf"\btheorem\s+{target}_closed\b", src), target
        assert target in doc

    assert "STATUS := TARGET_LADDER_COMPLETION_ONLY" in doc
    assert "BOUNDARY := ¬ unguarded_fo_formula_radius_construction" in doc
    assert "Classify the weakest remaining proof obstruction after the full target ladder." in doc

    print("QUANTIFIED_CONSTRUCTOR_REMAINING_LADDER_COMPLETION_OK")

if __name__ == "__main__":
    main()
