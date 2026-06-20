from pathlib import Path
import json

art = Path("artifacts/cslib_fmt/radius_zero_atomic_preservation_connection_lock_2026_06_20.json")
doc = Path("docs/status/RADIUS_ZERO_ATOMIC_PRESERVATION_CONNECTION_LOCK_2026_06_20.md")
lean = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(art.read_text())
doc_text = doc.read_text()
lean_text = lean.read_text()

assert data["status"] == "RADIUS_ZERO_ATOMIC_PRESERVATION_CONNECTION_PROVED"
assert data["radius"] == 0
assert data["scope"] == "atomic-only radius-zero preservation connection"

for theorem in [
    "assignment_gaifman_close_radius_zero_preservation",
    "equality_atom_locality_input_radius_zero",
    "relation_atom_locality_input_radius_zero",
]:
    assert theorem in data["connected_theorems"]
    assert f"theorem {theorem}" in lean_text
    assert theorem in doc_text

assert "AtomicLocalityInput M (Formula.eq x y) 0" in lean_text
assert "AtomicLocalityInput M (Formula.rel R args) 0" in lean_text
assert "AssignmentGaifmanClose M 0 ρ τ" in lean_text

for forbidden in [
    "Boolean recursion",
    "quantifier recursion",
    "positive-radius atomic preservation",
    "arbitrary formula locality",
    "formula radius construction",
    "full Gaifman locality",
]:
    assert forbidden in data["does_not_claim"]
    assert forbidden in doc_text

assert "RADIUS_ZERO_ATOMIC_PRESERVATION_CONNECTION_PROVED" in doc_text
assert "Boolean and quantifier recursion remain outside this lock." in doc_text

print("RADIUS_ZERO_ATOMIC_PRESERVATION_CONNECTION_LOCK_OK")
