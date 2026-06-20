from pathlib import Path
import json

ART = Path("artifacts/cslib_fmt/assignment_gaifman_close_preservation_replacement_target_lock_2026_06_20.json")
DOC = Path("docs/status/ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_REPLACEMENT_TARGET_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(ART.read_text(encoding="utf-8"))
doc = DOC.read_text(encoding="utf-8")
lean = LEAN.read_text(encoding="utf-8")

assert data["object"] == "AssignmentGaifmanClosePreservationReplacementTargetLock"
assert data["after_head"] == "2075380"
assert data["status"] == "ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_REPLACEMENT_TARGET_LOCK_ONLY"

target = data["locked_target"]
assert target["name"] == "AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget"
assert target["status"] == "TARGET_ONLY_NO_BRANCH_PROOF"

branch_names = {branch["name"] for branch in target["branches"]}
assert "radius_zero_preservation" in branch_names
assert "exact_assignment_close" in branch_names

for branch in target["branches"]:
    assert branch["proved"] is False

assert "structure AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget" in lean
assert "radius_zero_preservation" in lean
assert "exact_assignment_close" in lean
assert "exact_assignment_close_iff" in lean
assert "AssignmentGaifmanClose M 0 ρ τ" in lean
assert "∀ x : Fin n, ρ x = τ x" in lean

for forbidden in [
    "AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget inhabited",
    "radius-zero preservation proved",
    "exact assignment close branch proved",
    "unconditional equality atom locality",
    "unconditional relation atom locality",
    "unconditional atomic_formula_locality_input_exists",
    "Boolean recursion",
    "quantifier recursion",
    "Gaifman locality",
]:
    assert forbidden in data["does_not_claim"]

assert "ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_REPLACEMENT_TARGET_LOCK_ONLY" in doc
assert "This lock does not claim" in doc
assert "radius_zero_preservation" in doc
assert "exact_assignment_close_iff" in doc
assert "Boolean or quantifier recursion remains inadmissible" in doc
assert "RadiusZeroPreservationBranchClassificationOrExactAssignmentCloseAtomicInputTarget" in doc

print("ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_REPLACEMENT_TARGET_LOCK_OK")
