# Unguarded FO finite Boolean fold access status lock — 2026-06-20

STATUS := `FINITE_BOOLEAN_FOLD_ACCESS_STATUS_LOCK`

SCOPE :=

Status/documentation scoped lock only. No new Lean theorem is introduced by this lock.

LOCKED_CHAIN :=

- `finite_boolean_family_fold`
- `finite_boolean_family_fold_shared_radius`
- `finite_boolean_family_fold_atom_fragment_member`
- `finite_boolean_family_fold_neg_fragment_member`
- `finite_boolean_family_fold_conj_fragment_member`
- `finite_boolean_family_fold_disj_fragment_member`
- `finite_boolean_family_fold_with_radius_value_access`
- `finite_boolean_family_fold_radius_access`
- `finite_boolean_family_fold_pair_radius_access`
- `finite_boolean_family_fold_target_access`
- `finite_boolean_family_fold_target_fragment_access`
- `finite_boolean_family_fold_atom_constructor_access`
- `finite_boolean_family_fold_neg_constructor_access`
- `finite_boolean_family_fold_conj_constructor_access`
- `finite_boolean_family_fold_disj_constructor_access`
- `finite_boolean_family_fold_atom_shared_radius_input_access`
- `finite_boolean_family_fold_neg_shared_radius_input_access`
- `finite_boolean_family_fold_conj_left_shared_radius_input_access`
- `finite_boolean_family_fold_conj_right_shared_radius_input_access`
- `finite_boolean_family_fold_disj_left_shared_radius_input_access`
- `finite_boolean_family_fold_disj_right_shared_radius_input_access`
- `finite_boolean_family_fold_atom_target_fragment_input_access`
- `finite_boolean_family_fold_neg_target_fragment_input_access`
- `finite_boolean_family_fold_conj_target_fragment_input_access`
- `finite_boolean_family_fold_disj_target_fragment_input_access`
- `finite_boolean_family_fold_atom_target_locality_input_access`
- `finite_boolean_family_fold_neg_target_locality_input_access`
- `finite_boolean_family_fold_conj_target_locality_input_access`
- `finite_boolean_family_fold_disj_target_locality_input_access`
- `finite_boolean_family_fold_access_rollup`

VALIDATED_VERIFIER_CHAIN :=

- `UNGUARDED_FO_FINITE_BOOLEAN_FAMILY_FOLD_OK`
- `UNGUARDED_FO_FINITE_BOOLEAN_FOLD_MEMBERSHIP_OK`
- `UNGUARDED_FO_FINITE_BOOLEAN_FOLD_ACCESS_OK`
- `UNGUARDED_FO_FINITE_BOOLEAN_FOLD_CONSTRUCTOR_ACCESS_OK`
- `UNGUARDED_FO_FINITE_BOOLEAN_FOLD_SHARED_RADIUS_INPUT_ACCESS_OK`
- `UNGUARDED_FO_FINITE_BOOLEAN_FOLD_TARGET_FRAGMENT_INPUT_ACCESS_OK`
- `UNGUARDED_FO_FINITE_BOOLEAN_FOLD_TARGET_LOCALITY_INPUT_ACCESS_OK`
- `UNGUARDED_FO_FINITE_BOOLEAN_FOLD_ACCESS_ROLLUP_OK`

BOUNDARY :=

This lock records expression-index scoped finite Boolean fold access over `FiniteBooleanFamilyExpr` only.

It is not arbitrary bounded-fragment closure.

Still no formula-radius construction theorem, no existence of atomic locality inputs, no radius monotonicity, no arbitrary bounded-fragment closure, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.

NEXT_TARGET := stop this access chain unless a concrete downstream theorem forces another missing expression-index scoped access lemma.
