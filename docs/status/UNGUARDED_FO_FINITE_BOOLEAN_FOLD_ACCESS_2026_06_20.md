# Unguarded FO finite Boolean fold access lemmas — 2026-06-20

STATUS := `FINITE_BOOLEAN_FAMILY_FOLD_RADIUS_TARGET_ACCESS_LEMMAS`

ADDED_LAYER :=

- `finite_boolean_family_fold_with_radius_value_access`
- `finite_boolean_family_fold_radius_access`
- `finite_boolean_family_fold_pair_radius_access`
- `finite_boolean_family_fold_target_access`
- `finite_boolean_family_fold_target_fragment_access`

VALIDATED_SURFACE :=

This layer extracts expression-index scoped fold radius access lemmas and fold target access lemmas for the explicit finite Boolean expression syntax.

The theorem statements remain over `FiniteBooleanFamilyExpr`.

BOUNDARY :=

This is expression-index scoped fold radius and target projection access only, not arbitrary bounded-fragment closure.

Still no formula-radius construction theorem, no existence of atomic locality inputs, no radius monotonicity, no arbitrary bounded-fragment closure, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.

NEXT_TARGET := extract expression-index scoped fold constructor access lemmas for atom, neg, conj, and disj without generalizing to arbitrary fragments.
