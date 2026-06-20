from pathlib import Path
import json

ART = Path("artifacts/cslib_fmt/assignment_gaifman_close_preservation_target_lock_2026_06_20.json")
DOC = Path("docs/status/ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_TARGET_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(ART.read_text(encoding="utf-8"))
doc = DOC.read_text(encoding="utf-8")
lean = LEAN.read_text(encoding="utf-8")

assert data["object"] == "AssignmentGaifmanClosePreservationTargetLock"
assert data["after_head"] == "0031af2"
assert data["status"] == "ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_TARGET_LOCK_ONLY"

target = data["locked_target"]
assert target["name"] == "AssignmentGaifmanClosePreservationTarget"
assert target["status"] == "TARGET_SHELL_ONLY_NO_PRESERVATION_PROOF"

assert "structure AssignmentGaifmanClosePreservationTarget" in lean
assert "AssignmentGaifmanClose M r ρ τ" in lean
assert "∀ x : Fin n, ρ x = τ x" in lean

for forbidden in [
    "AssignmentGaifmanClosePreservationTarget inhabited",
    "assignment preservation under AssignmentGaifmanClose",
    "unconditional equality atom locality",
    "unconditional relation atom locality",
    "unconditional atomic_formula_locality_input_exists",
    "Boolean recursion",
    "quantifier recursion",
    "Gaifman locality",
]:
    assert forbidden in data["does_not_claim"]

assert "ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_TARGET_LOCK_ONLY" in doc
assert "This lock does not claim" in doc
assert "Boolean or quantifier recursion remains inadmissible" in doc
assert "AssignmentGaifmanClosePreservationTargetClassification" in doc

print("ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_TARGET_LOCK_OK")
