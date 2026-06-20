from pathlib import Path
import json

art = Path("artifacts/cslib_fmt/boolean_recursion_gate_after_radius_zero_atomic_connection_2026_06_20.json")
doc = Path("docs/status/BOOLEAN_RECURSION_GATE_AFTER_RADIUS_ZERO_ATOMIC_CONNECTION_2026_06_20.md")
lean = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
lock = Path("artifacts/cslib_fmt/radius_zero_atomic_preservation_connection_lock_2026_06_20.json")

data = json.loads(art.read_text())
lock_data = json.loads(lock.read_text())
doc_text = doc.read_text()
lean_text = lean.read_text()

assert lock_data["status"] == "RADIUS_ZERO_ATOMIC_PRESERVATION_CONNECTION_PROVED"
assert data["status"] == "BOOLEAN_RECURSION_GATE_TOUCHED_STATUS_TEST_ONLY"
assert data["prerequisite_lock"] == "RADIUS_ZERO_ATOMIC_PRESERVATION_CONNECTION_PROVED"
assert data["available_atomic_radius"] == 0
assert data["classification"] == "GATE_OPEN_FOR_BOUNDED_BOOLEAN_STATUS_TEST_ONLY"
assert data["next_admissible_object"] == "BoundedBooleanRadiusZeroConstructorTarget"

for theorem in [
    "equality_atom_locality_input_radius_zero",
    "relation_atom_locality_input_radius_zero",
]:
    assert theorem in data["available_atomic_theorems"]
    assert f"theorem {theorem}" in lean_text
    assert theorem in doc_text

assert "A proved Boolean constructor layer preserving a shared radius" in data[
    "weakest_missing_for_formula_recursion"
]
assert "BOOLEAN_RECURSION_GATE_TOUCHED_STATUS_TEST_ONLY" in doc_text
assert "GATE_OPEN_FOR_BOUNDED_BOOLEAN_STATUS_TEST_ONLY" in doc_text
assert "bounded Boolean radius-zero constructor target" in doc_text

for forbidden in [
    "Boolean recursion theorem proved",
    "quantifier recursion theorem proved",
    "arbitrary formula locality",
    "formula radius construction",
    "positive-radius atomic preservation",
    "full Gaifman locality",
]:
    assert forbidden in data["does_not_claim"]
    assert forbidden in doc_text

print("BOOLEAN_RECURSION_GATE_AFTER_RADIUS_ZERO_ATOMIC_CONNECTION_OK")
