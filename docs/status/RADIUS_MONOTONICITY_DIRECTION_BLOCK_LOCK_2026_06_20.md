# Radius Monotonicity Direction Block Lock

PROGRESS_ID := cslib_fmt_radius_monotonicity_direction_block_lock_2026_06_20

STATUS := RADIUS_MONOTONICITY_DIRECTION_BLOCK_LOCK_ONLY

The current proved close monotonicity lemma is:

`assignment_gaifman_close_mono`

with direction:

`r ≤ s → AssignmentGaifmanClose M r ρ τ → AssignmentGaifmanClose M s ρ τ`

This is the correct forward direction for the pointwise distance-bound
definition of `AssignmentGaifmanClose`.

BLOCKED_CLAIM :=

The earlier target shape:

`r ≤ s → UnguardedFOLocalityInputSurface M φ r → UnguardedFOLocalityInputSurface M φ s`

is not directly derivable from the current surface. To use an invariant at
radius `r` on a hypothesis close at radius `s`, one would need the reverse close
conversion:

`AssignmentGaifmanClose M s ρ τ → AssignmentGaifmanClose M r ρ τ`

which is not available from `r ≤ s`.

ADMISSIBLE_REPLACEMENT_DIRECTION :=

The directly admissible locality-surface weakening direction is:

`s ≤ r → UnguardedFOLocalityInputSurface M φ r → UnguardedFOLocalityInputSurface M φ s`

because a smaller-radius close hypothesis can be forwarded to the larger radius
required by the existing invariant.

NONCLAIMS :=

- No proof of radius monotonicity of locality input surfaces.
- No proof of reverse assignment-close monotonicity.
- No proof of max-radius conjunction closure.
- No proof of max-radius disjunction closure.
- No proof of existential quantifier recursion.
- No proof of arbitrary formula-radius construction.
- No proof of unguarded FO Gaifman locality.
- No proof of Fagin's theorem.
- No proof of the 0-1 Law.
- No proof of general finite model theory closure.

NEXT_BOUNDARY :=

The weakest next admissible formal step is to add only the replacement
smaller-radius weakening lemma for `UnguardedFOLocalityInputSurface`.
