from pathlib import Path
import json

lean_path = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_atomic_locality_input_existence_target_2026_06_20.json")
doc_path = Path("docs/status/UNGUARDED_FO_ATOMIC_LOCALITY_INPUT_EXISTENCE_TARGET_2026_06_20.md")

for path in [lean_path, artifact_path, doc_path]:
    assert path.exists(), str(path)

lean = lean_path.read_text(encoding="utf-8")
artifact = json.loads(artifact_path.read_text(encoding="utf-8"))
doc = doc_path.read_text(encoding="utf-8")

assert artifact["status"] == "ATOMIC_LOCALITY_INPUT_EXISTENCE_TARGET_ONLY"
assert artifact["scope"] == "status/documentation scoped target only; no new Lean theorem"
assert artifact["previous_gap"] == "FORMULA_RADIUS_CONSTRUCTION_GAP_TARGET"
assert artifact["weakest_missing_object"] == "atomic locality input existence"
assert "NEXT_TARGET := stop before any atomic existence theorem" in doc

required_target_shape = [
    "given an atomic formula, identify the exact locality input package that would be required",
    "record the obligation without asserting existence for arbitrary atoms",
    "keep the target below formula-radius recursive construction",
    "do not generalize finite Boolean fold access to arbitrary fragments",
]

for item in required_target_shape:
    assert item in artifact["target_statement_shape"], item
    assert item in doc, item

required_forbidden = [
    "existence for arbitrary atoms",
    "recursive formula-radius construction theorem",
    "arbitrary bounded-fragment closure",
    "unguarded FO locality theorem",
]

for item in required_forbidden:
    assert item in artifact["forbidden_claims"], item
    assert item in doc, item

required_blocked = [
    "formula-radius construction theorem",
    "recursive formula syntax radius assignment",
    "fragment-membership bridge for all recursive construction outputs",
]

for item in required_blocked:
    assert item in artifact["blocked_downstream_theorems"], item
    assert item in doc, item

required_boundaries = [
    "atomic locality input existence",
    "existence for arbitrary atoms",
    "formula-radius construction theorem",
    "arbitrary bounded-fragment closure",
    "radius monotonicity",
    "unguarded FO locality theorem",
    "full Gaifman locality",
    "Fagin theorem",
    "0-1 Law",
    "general FMT closure",
]

for boundary in required_boundaries:
    assert boundary in artifact["does_not_prove"], boundary
    assert boundary in doc, boundary

for forbidden_lean_name in [
    "atomic_locality_input_existence",
    "arbitrary_atomic_locality_input_existence",
    "formula_radius_construction_theorem",
]:
    assert "theorem " + forbidden_lean_name not in lean, forbidden_lean_name

print("UNGUARDED_FO_ATOMIC_LOCALITY_INPUT_EXISTENCE_TARGET_OK")
