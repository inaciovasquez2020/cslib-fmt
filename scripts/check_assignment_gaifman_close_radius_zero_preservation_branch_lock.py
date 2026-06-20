from pathlib import Path
import json

art = Path("artifacts/cslib_fmt/assignment_gaifman_close_radius_zero_preservation_branch_lock_2026_06_20.json")
doc = Path("docs/status/ASSIGNMENT_GAIFMAN_CLOSE_RADIUS_ZERO_PRESERVATION_BRANCH_LOCK_2026_06_20.md")
lean = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(art.read_text())
doc_text = doc.read_text()
lean_text = lean.read_text()

assert data["status"] == "RADIUS_ZERO_PRESERVATION_BRANCH_PROVED"
assert data["proved_branch"] == "radius_zero_preservation"
assert "gaifman_distance_le_zero_eq" in data["proved_theorems"]
assert "assignment_gaifman_close_radius_zero_preservation" in data["proved_theorems"]
assert "theorem gaifman_distance_le_zero_eq" in lean_text
assert "theorem assignment_gaifman_close_radius_zero_preservation" in lean_text
assert "AssignmentGaifmanClose M 0 ρ τ" in lean_text
assert "∀ x : Fin n, ρ x = τ x" in lean_text

for forbidden in [
    "exact_assignment_close branch proved",
    "unconditional positive-radius assignment equality",
    "unconditional equality atom locality",
    "unconditional relation atom locality",
    "unconditional atomic_formula_locality_input_exists",
    "Boolean recursion",
    "quantifier recursion",
    "Gaifman locality",
]:
    assert forbidden in data["does_not_claim"]

assert "RADIUS_ZERO_PRESERVATION_BRANCH_PROVED" in doc_text
assert "assignment_gaifman_close_radius_zero_preservation" in doc_text
assert "Boolean or quantifier recursion remains inadmissible" in doc_text

print("ASSIGNMENT_GAIFMAN_CLOSE_RADIUS_ZERO_PRESERVATION_BRANCH_LOCK_OK")
