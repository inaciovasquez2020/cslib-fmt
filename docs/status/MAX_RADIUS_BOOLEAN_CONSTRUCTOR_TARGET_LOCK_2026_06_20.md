# Max-Radius Boolean Constructor Target Lock

PROGRESS_ID := cslib_fmt_max_radius_boolean_constructor_target_lock_2026_06_20

STATUS := MAX_RADIUS_BOOLEAN_CONSTRUCTOR_TARGET_LOCK_ONLY

This status lock records the target shell:

`MaxRadiusBooleanConstructorTarget`

in:

`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

The structure records the next obstruction after the same-radius Boolean rollup:
Boolean combinations whose input surfaces are available at possibly different
radii.

The object contains:

- `same_radius_rollup`;
- `conj_max_radius_obligation`;
- `disj_max_radius_obligation`;
- `radius_monotonicity_obligation`.

This is target-only.

NONCLAIMS :=

- No proof of radius monotonicity.
- No proof of max-radius conjunction closure.
- No proof of max-radius disjunction closure.
- No proof of shared-radius Boolean family recursion.
- No proof of existential quantifier recursion.
- No proof of arbitrary formula-radius construction.
- No proof of unguarded FO Gaifman locality.
- No proof of Fagin's theorem.
- No proof of the 0-1 Law.
- No proof of general finite model theory closure.

NEXT_BOUNDARY :=

The weakest next admissible formal step is a target or lemma for radius
monotonicity. Do not add quantifier recursion in the same step.
