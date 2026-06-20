# Unguarded FO finite Boolean family fold — 2026-06-20

STATUS := `FINITE_BOOLEAN_FAMILY_FOLD_EXPLICIT_SHARED_RADIUS`

BASE := `64709d9 theorem: add shared radius family introductions`

ADDED_LAYER :=

- `FiniteBooleanFamilyExpr`
- `finite_boolean_family_fold_with_radius`
- `finite_boolean_family_fold`
- `finite_boolean_family_fold_shared_radius`

VALIDATED_SURFACE :=

This layer folds an explicit finite Boolean expression syntax over an indexed environment of `SharedRadiusTargetFamily` values.

The environment carries an explicit shared radius invariant:

`∀ i, (env i).sharedRadius = sharedRadius`

The fold preserves the invariant through each constructor step. Atomic leaves use the environment invariant. Negation keeps the same family radius. Conjunction and disjunction build a `SharedRadiusTargetFamilyPair` at each step using the already-proved shared-radius invariant for both subexpressions.

BOUNDARY :=

This is not arbitrary bounded-fragment closure. It is only a fold over an explicit finite syntax/index object under an explicit shared-radius environment.

Still no formula-radius construction theorem, no existence of atomic locality inputs, no radius monotonicity, no arbitrary bounded-fragment closure, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.

NEXT_TARGET := extract finite Boolean fold target and fragment membership lemmas.
