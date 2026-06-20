# Radius Monotonicity Target Lock

PROGRESS_ID := cslib_fmt_radius_monotonicity_target_lock_2026_06_20

STATUS := RADIUS_MONOTONICITY_TARGET_LOCK_ONLY

This status lock records the target shell:

`RadiusMonotonicityTarget`

in:

`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

The structure records the monotonicity obstruction needed before max-radius
Boolean constructors can be discharged: lifting a locality input surface from
radius `r` to a larger radius `s`.

The object contains:

- `monotonicity_obligation`;
- `expected_lift_shape`.

This is target-only.

NONCLAIMS :=

- No proof of radius monotonicity.
- No proof of assignment-close monotonicity.
- No proof of max-radius conjunction closure.
- No proof of max-radius disjunction closure.
- No proof of existential quantifier recursion.
- No proof of arbitrary formula-radius construction.
- No proof of unguarded FO Gaifman locality.
- No proof of Fagin's theorem.
- No proof of the 0-1 Law.
- No proof of general finite model theory closure.

NEXT_BOUNDARY :=

The weakest next admissible formal step is assignment-close monotonicity, since
radius monotonicity of input surfaces depends on converting an
`AssignmentGaifmanClose M s ρ τ` hypothesis into the smaller-radius close
hypothesis required by an input surface at radius `r`.
