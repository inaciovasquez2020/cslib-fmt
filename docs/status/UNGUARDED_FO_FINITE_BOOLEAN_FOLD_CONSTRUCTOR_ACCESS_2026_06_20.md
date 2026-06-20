# Unguarded FO finite Boolean fold constructor access lemmas — 2026-06-20

STATUS := `FINITE_BOOLEAN_FAMILY_FOLD_CONSTRUCTOR_ACCESS_LEMMAS`

ADDED_LAYER :=

- `finite_boolean_family_fold_atom_constructor_access`
- `finite_boolean_family_fold_neg_constructor_access`
- `finite_boolean_family_fold_conj_constructor_access`
- `finite_boolean_family_fold_disj_constructor_access`

VALIDATED_SURFACE :=

This layer extracts expression-index scoped fold constructor access lemmas for atom, negation, conjunction, and disjunction cases.

The theorem statements remain over `FiniteBooleanFamilyExpr`.

BOUNDARY :=

This is expression-index scoped constructor access for the explicit finite Boolean fold only, not arbitrary bounded-fragment closure.

Still no formula-radius construction theorem, no existence of atomic locality inputs, no radius monotonicity, no arbitrary bounded-fragment closure, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.

NEXT_TARGET := extract expression-index scoped fold shared-radius input access lemmas without generalizing to arbitrary fragments.
