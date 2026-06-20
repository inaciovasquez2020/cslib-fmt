from pathlib import Path
import json

ART = Path("artifacts/cslib_fmt/assignment_gaifman_close_preservation_target_classification_2026_06_20.json")
DOC = Path("docs/status/ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_TARGET_CLASSIFICATION_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(ART.read_text(encoding="utf-8"))
doc = DOC.read_text(encoding="utf-8")
lean = LEAN.read_text(encoding="utf-8")

assert data["object"] == "AssignmentGaifmanClosePreservationTargetClassification"
assert data["after_head"] == "e8a8408"
assert data["status"] == "CLASSIFIED_IMPOSSIBLE_AS_UNCONDITIONAL_GLOBAL_TARGET"
assert data["classification"] == "IMPOSSIBLE_AS_UNCONDITIONAL_GLOBAL_TARGET_FROM_CURRENT_DEFINITIONS"

assert "structure AssignmentGaifmanClosePreservationTarget" in lean
assert "AssignmentGaifmanClose M r ρ τ" in lean
assert "∀ x : Fin n, ρ x = τ x" in lean

assert "bounded Gaifman-distance condition" in data["exact_structural_obstruction"]
assert "not an assignment-equality condition" in data["exact_structural_obstruction"]
assert "positive radius" in data["exact_structural_obstruction"]
assert "AssignmentExactOnFreeVariables" in data["weakest_strengthened_assignment_close_definition"]
assert data["weakest_admissible_replacement_target"] == (
    "AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget"
)

for forbidden in [
    "AssignmentGaifmanClosePreservationTarget inhabited",
    "assignment equality follows from AssignmentGaifmanClose",
    "unconditional equality atom locality",
    "unconditional relation atom locality",
    "unconditional atomic_formula_locality_input_exists",
    "Boolean recursion",
    "quantifier recursion",
    "Gaifman locality",
]:
    assert forbidden in data["does_not_claim"]

assert "CLASSIFIED_IMPOSSIBLE_AS_UNCONDITIONAL_GLOBAL_TARGET" in doc
assert "Exact structural obstruction" in doc
assert "not an assignment-equality condition" in doc
assert "For positive radius, distinct adjacent elements may be Gaifman-close" in doc
assert "Boolean or quantifier recursion remains inadmissible" in doc

print("ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_TARGET_CLASSIFICATION_OK")
