# Shared-Radius Boolean Constructor Rollup Lock

PROGRESS_ID := cslib_fmt_shared_radius_boolean_rollup_constructor_lock_2026_06_20

STATUS := SHARED_RADIUS_BOOLEAN_CONSTRUCTOR_ROLLUP_LOCK_ONLY

This status lock records the package-only constructor theorem:

`shared_radius_boolean_constructor_rollup`

in:

`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

The theorem constructs:

`SharedRadiusBooleanConstructorRollupTarget M`

from the three already proved same-radius Boolean constructor lemmas:

- `unguarded_fo_neg_radius_constructor`;
- `unguarded_fo_conj_same_radius_constructor`;
- `unguarded_fo_disj_same_radius_constructor`.

NONCLAIMS :=

- No proof of shared-radius Boolean family recursion.
- No proof of max-radius Boolean recursion.
- No proof of existential quantifier recursion.
- No proof of arbitrary formula-radius construction.
- No proof of unguarded FO Gaifman locality.
- No proof of Fagin's theorem.
- No proof of the 0-1 Law.
- No proof of general finite model theory closure.

NEXT_BOUNDARY :=

The weakest next admissible formal step is a status stop or a new target-only
surface for max-radius Boolean combination. Do not add quantifier recursion in
the same step.
