from pathlib import Path
import json

lean_path = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_finite_boolean_fold_access_status_lock_2026_06_20.json")
doc_path = Path("docs/status/UNGUARDED_FO_FINITE_BOOLEAN_FOLD_ACCESS_STATUS_LOCK_2026_06_20.md")

for path in [lean_path, artifact_path, doc_path]:
    assert path.exists(), str(path)

lean = lean_path.read_text(encoding="utf-8")
artifact = json.loads(artifact_path.read_text(encoding="utf-8"))
doc = doc_path.read_text(encoding="utf-8")

locked_layers = [
    "finite_boolean_family_fold",
    "finite_boolean_family_fold_shared_radius",
    "finite_boolean_family_fold_atom_fragment_member",
    "finite_boolean_family_fold_neg_fragment_member",
    "finite_boolean_family_fold_conj_fragment_member",
    "finite_boolean_family_fold_disj_fragment_member",
    "finite_boolean_family_fold_with_radius_value_access",
    "finite_boolean_family_fold_radius_access",
    "finite_boolean_family_fold_pair_radius_access",
    "finite_boolean_family_fold_target_access",
    "finite_boolean_family_fold_target_fragment_access",
    "finite_boolean_family_fold_atom_constructor_access",
    "finite_boolean_family_fold_neg_constructor_access",
    "finite_boolean_family_fold_conj_constructor_access",
    "finite_boolean_family_fold_disj_constructor_access",
    "finite_boolean_family_fold_atom_shared_radius_input_access",
    "finite_boolean_family_fold_neg_shared_radius_input_access",
    "finite_boolean_family_fold_conj_left_shared_radius_input_access",
    "finite_boolean_family_fold_conj_right_shared_radius_input_access",
    "finite_boolean_family_fold_disj_left_shared_radius_input_access",
    "finite_boolean_family_fold_disj_right_shared_radius_input_access",
    "finite_boolean_family_fold_atom_target_fragment_input_access",
    "finite_boolean_family_fold_neg_target_fragment_input_access",
    "finite_boolean_family_fold_conj_target_fragment_input_access",
    "finite_boolean_family_fold_disj_target_fragment_input_access",
    "finite_boolean_family_fold_atom_target_locality_input_access",
    "finite_boolean_family_fold_neg_target_locality_input_access",
    "finite_boolean_family_fold_conj_target_locality_input_access",
    "finite_boolean_family_fold_disj_target_locality_input_access",
    "finite_boolean_family_fold_access_rollup",
]

for name in locked_layers:
    assert name in lean, name
    assert name in artifact["locked_layers"], name
    assert name in doc, name

required_verifiers = [
    "UNGUARDED_FO_FINITE_BOOLEAN_FAMILY_FOLD_OK",
    "UNGUARDED_FO_FINITE_BOOLEAN_FOLD_MEMBERSHIP_OK",
    "UNGUARDED_FO_FINITE_BOOLEAN_FOLD_ACCESS_OK",
    "UNGUARDED_FO_FINITE_BOOLEAN_FOLD_CONSTRUCTOR_ACCESS_OK",
    "UNGUARDED_FO_FINITE_BOOLEAN_FOLD_SHARED_RADIUS_INPUT_ACCESS_OK",
    "UNGUARDED_FO_FINITE_BOOLEAN_FOLD_TARGET_FRAGMENT_INPUT_ACCESS_OK",
    "UNGUARDED_FO_FINITE_BOOLEAN_FOLD_TARGET_LOCALITY_INPUT_ACCESS_OK",
    "UNGUARDED_FO_FINITE_BOOLEAN_FOLD_ACCESS_ROLLUP_OK",
]

for name in required_verifiers:
    assert name in artifact["verifier_chain"], name
    assert name in doc, name

required_scope = [
    "status/documentation scoped lock only",
    "the locked theorem statements remain over FiniteBooleanFamilyExpr",
    "finite Boolean fold access is expression-index scoped",
    "no new Lean theorem is introduced by this lock",
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

assert artifact["status"] == "FINITE_BOOLEAN_FOLD_ACCESS_STATUS_LOCK"
assert "NEXT_TARGET := stop this access chain" in doc

print("UNGUARDED_FO_FINITE_BOOLEAN_FOLD_ACCESS_STATUS_LOCK_OK")
