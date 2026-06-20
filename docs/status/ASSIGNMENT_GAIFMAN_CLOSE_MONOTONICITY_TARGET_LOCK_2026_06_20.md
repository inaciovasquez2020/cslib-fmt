# Assignment Gaifman Close Monotonicity Target Lock

PROGRESS_ID := cslib_fmt_assignment_close_monotonicity_target_lock_2026_06_20

STATUS := ASSIGNMENT_GAIFMAN_CLOSE_MONOTONICITY_TARGET_LOCK_ONLY

This status lock records the target shell:

`AssignmentGaifmanCloseMonotonicityTarget`

in:

`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

The structure records the immediate dependency needed by radius monotonicity of
locality input surfaces: converting a larger-radius assignment-close hypothesis
into the smaller-radius assignment-close shape required by an input surface.

The object contains:

- `close_monotonicity_obligation`;
- `expected_close_lift_shape`.

This is target-only.

NONCLAIMS :=

- No proof of assignment-close monotonicity.
- No proof of radius monotonicity.
- No proof of max-radius conjunction closure.
- No proof of max-radius disjunction closure.
- No proof of existential quantifier recursion.
- No proof of arbitrary formula-radius construction.
- No proof of unguarded FO Gaifman locality.
- No proof of Fagin's theorem.
- No proof of the 0-1 Law.
- No proof of general finite model theory closure.

NEXT_BOUNDARY :=

The weakest next admissible formal step is inspecting the actual definition of
`AssignmentGaifmanClose` and adding only the smallest assignment-close
monotonicity lemma if its definition is pointwise enough to discharge directly.
