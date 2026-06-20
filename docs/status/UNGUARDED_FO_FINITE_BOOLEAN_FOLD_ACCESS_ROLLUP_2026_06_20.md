# Unguarded FO finite Boolean fold access rollup — 2026-06-20

STATUS := `FINITE_BOOLEAN_FAMILY_FOLD_ACCESS_ROLLUP_THEOREM`

ADDED_LAYER :=

- `finite_boolean_family_fold_access_rollup`

VALIDATED_SURFACE :=

This layer extracts a compact expression-index scoped finite Boolean fold access rollup theorem.

The theorem statement remains over `FiniteBooleanFamilyExpr`.

ROLLED_UP_ACCESS :=

- shared radius access
- fold-with-radius value access
- target projection access
- target fragment projection access

USED_ACCESS_OBJECTS :=

- `finite_boolean_family_fold_radius_access`
- `finite_boolean_family_fold_with_radius_value_access`
- `finite_boolean_family_fold_target_access`
- `finite_boolean_family_fold_target_fragment_access`

BOUNDARY :=

This is a compact expression-index scoped finite Boolean fold access rollup only, not arbitrary bounded-fragment closure.

Still no formula-radius construction theorem, no existence of atomic locality inputs, no radius monotonicity, no arbitrary bounded-fragment closure, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.

NEXT_TARGET := add a final finite Boolean fold access status lock if no additional expression-index scoped access theorem is needed.
