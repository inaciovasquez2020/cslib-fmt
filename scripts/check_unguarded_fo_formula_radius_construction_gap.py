from pathlib import Path
import json

lean_path = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_formula_radius_construction_gap_2026_06_20.json")
doc_path = Path("docs/status/UNGUARDED_FO_FORMULA_RADIUS_CONSTRUCTION_GAP_2026_06_20.md")

for path in [lean_path, artifact_path, doc_path]:
    assert path.exists(), str(path)

lean = lean_path.read_text(encoding="utf-8")
artifact = json.loads(artifact_path.read_text(encoding="utf-8"))
doc = doc_path.read_text(encoding="utf-8")

assert artifact["status"] == "FORMULA_RADIUS_CONSTRUCTION_GAP_TARGET"
assert artifact["scope"] == "status/documentation scoped gap target; no new Lean theorem"
assert artifact["previous_chain_stop"] == "FINITE_BOOLEAN_FOLD_ACCESS_STATUS_LOCK"
assert artifact["weakest_gap"] == "atomic locality input existence"
assert "NEXT_TARGET := add a status-only atomic locality input existence target." in doc

required_ranked_gaps = [
    "atomic locality input existence",
    "constructor-local radius propagation specification",
    "formula syntax recursion target for all Formula constructors",
    "radius monotonicity or explicit radius equality transport",
    "fragment-membership bridge from recursive construction outputs",
    "full formula-radius construction theorem",
]

for item in required_ranked_gaps:
    assert item in artifact["ranked_gaps"], item
    assert item in doc, item

required_blockers = [
    "finite Boolean fold access is expression-index scoped only",
    "atomic locality input existence is not yet provided",
    "no global recursive radius assignment over all Formula constructors is proved",
    "no monotonicity/transport layer for changing radii is proved",
]

for item in required_blockers:
    assert item in artifact["blocked_reason"], item
    assert item in doc, item

required_boundaries = [
    "atomic locality input existence",
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

assert "finite_boolean_family_fold_access_rollup" in lean
assert "FiniteBooleanFamilyExpr" in lean

print("UNGUARDED_FO_FORMULA_RADIUS_CONSTRUCTION_GAP_OK")
