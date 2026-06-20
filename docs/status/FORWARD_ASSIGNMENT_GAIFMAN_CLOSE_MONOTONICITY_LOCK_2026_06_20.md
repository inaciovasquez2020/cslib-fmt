# Forward Assignment Gaifman Close Monotonicity Lock

PROGRESS_ID := cslib_fmt_forward_assignment_close_monotonicity_lock_2026_06_20

STATUS := FORWARD_ASSIGNMENT_GAIFMAN_CLOSE_MONOTONICITY_LOCK_ONLY

This status lock records two proved forward monotonicity lemmas in:

`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

The locked lemmas are:

- `gaifman_distance_le_mono`;
- `assignment_gaifman_close_mono`.

The proved direction is:

`r ≤ s → AssignmentGaifmanClose M r ρ τ → AssignmentGaifmanClose M s ρ τ`

This is the direction directly supported by the current pointwise definition of
`AssignmentGaifmanClose`.

REVERSE_DIRECTION_STATUS := NOT_AVAILABLE_FROM_CURRENT_DEFINITION

The reverse direction:

`AssignmentGaifmanClose M s ρ τ → AssignmentGaifmanClose M r ρ τ`

is not available from the current definition merely from `r ≤ s`.

NONCLAIMS :=

- No proof of reverse assignment-close monotonicity.
- No proof of radius monotonicity of locality input surfaces.
- No proof of max-radius conjunction closure.
- No proof of max-radius disjunction closure.
- No proof of existential quantifier recursion.
- No proof of arbitrary formula-radius construction.
- No proof of unguarded FO Gaifman locality.
- No proof of Fagin's theorem.
- No proof of the 0-1 Law.
- No proof of general finite model theory closure.

NEXT_BOUNDARY :=

The weakest next admissible formal step is to classify the radius-monotonicity
target as blocked under the current direction, or to introduce a separate
shrinking/strengthening assumption if the program needs larger-radius input
surfaces to reuse smaller-radius invariants.
