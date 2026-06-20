from pathlib import Path
import json

lean_path = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
atomic_artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_atomic_locality_input_existence_target_2026_06_20.json")
stop_artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_formula_radius_frontier_stop_2026_06_20.json")
stop_doc_path = Path("docs/status/UNGUARDED_FO_FORMULA_RADIUS_FRONTIER_STOP_2026_06_20.md")

for path in [lean_path, atomic_artifact_path, stop_artifact_path, stop_doc_path]:
    assert path.exists(), str(path)

lean = lean_path.read_text(encoding="utf-8")
atomic_artifact = json.loads(atomic_artifact_path.read_text(encoding="utf-8"))
stop_artifact = json.loads(stop_artifact_path.read_text(encoding="utf-8"))
doc = stop_doc_path.read_text(encoding="utf-8")

assert atomic_artifact["status"] == "ATOMIC_LOCALITY_INPUT_EXISTENCE_TARGET_ONLY"
assert stop_artifact["status"] == "FORMULA_RADIUS_FRONTIER_STOP"
assert stop_artifact["scope"] == "status/documentation scoped final stopping point; no new Lean theorem"
assert stop_artifact["weakest_remaining_point"] == "atomic locality input existence"
assert "Only continue if a concrete downstream theorem forces a named conditional atomic locality obligation surface." in doc

required_chain = [
    "FINITE_BOOLEAN_FOLD_ACCESS_STATUS_LOCK",
    "FORMULA_RADIUS_CONSTRUCTION_GAP_TARGET",
    "ATOMIC_LOCALITY_INPUT_EXISTENCE_TARGET_ONLY",
]

for item in required_chain:
    assert item in stop_artifact["closed_chain"], item
    assert item in doc, item

required_stop_reasons = [
    "finite Boolean fold access chain is complete enough for expression-index scoped access",
    "formula-radius construction is blocked by atomic locality input existence",
    "arbitrary atomic existence must not be asserted",
    "recursive formula-radius construction must not be introduced before atomic input and radius transport obligations",
]

for item in required_stop_reasons:
    assert item in stop_artifact["stop_reason"], item
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
    assert boundary in stop_artifact["does_not_prove"], boundary
    assert boundary in doc, boundary

for forbidden_lean_name in [
    "atomic_locality_input_existence",
    "arbitrary_atomic_locality_input_existence",
    "formula_radius_construction_theorem",
]:
    assert "theorem " + forbidden_lean_name not in lean, forbidden_lean_name

print("UNGUARDED_FO_FORMULA_RADIUS_FRONTIER_STOP_OK")
