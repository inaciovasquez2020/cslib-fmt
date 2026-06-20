from pathlib import Path
import json

lean_path = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_finite_boolean_fold_access_2026_06_20.json")
doc_path = Path("docs/status/UNGUARDED_FO_FINITE_BOOLEAN_FOLD_ACCESS_2026_06_20.md")

for path in [lean_path, artifact_path, doc_path]:
    assert path.exists(), str(path)

lean = lean_path.read_text(encoding="utf-8")
artifact = json.loads(artifact_path.read_text(encoding="utf-8"))
doc = doc_path.read_text(encoding="utf-8")

required_lemmas = [
    "finite_boolean_family_fold_with_radius_value_access",
    "finite_boolean_family_fold_radius_access",
    "finite_boolean_family_fold_pair_radius_access",
    "finite_boolean_family_fold_target_access",
    "finite_boolean_family_fold_target_fragment_access",
]

for name in required_lemmas:
    assert "theorem " + name in lean, name
    assert name in artifact["added_objects"], name
    assert name in doc, name

required_scope = [
    "theorem statements remain over FiniteBooleanFamilyExpr",
    "expression-index scoped fold radius access only",
    "expression-index scoped fold target access only",
    "not arbitrary bounded-fragment closure",
]

for phrase in required_scope:
    assert phrase in artifact["bounded_scope"] or phrase in doc, phrase

required_boundaries = [
    "arbitrary bounded-fragment closure",
    "formula-radius construction theorem",
    "existence of atomic locality inputs",
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

assert artifact["status"] == "FINITE_BOOLEAN_FAMILY_FOLD_RADIUS_TARGET_ACCESS_LEMMAS"
assert "NEXT_TARGET := extract expression-index scoped fold constructor access lemmas" in doc

print("UNGUARDED_FO_FINITE_BOOLEAN_FOLD_ACCESS_OK")
