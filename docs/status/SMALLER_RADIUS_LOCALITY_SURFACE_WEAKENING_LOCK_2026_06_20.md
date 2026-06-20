# Smaller-Radius Locality Surface Weakening Lock

PROGRESS_ID := cslib_fmt_smaller_radius_locality_surface_weakening_lock_2026_06_20

STATUS := SMALLER_RADIUS_LOCALITY_SURFACE_WEAKENING_LOCK_ONLY

This status lock records the theorem:

`unguarded_fo_locality_input_surface_weaken_radius`

in:

`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

The proved direction is:

`s ≤ r → UnguardedFOLocalityInputSurface M φ r → UnguardedFOLocalityInputSurface M φ s`

This is the direction compatible with the already proved forward assignment-close
monotonicity lemma:

`assignment_gaifman_close_mono`

The proof forwards a smaller-radius assignment-close hypothesis into the larger
radius required by the existing invariant.

NONCLAIMS :=

- No proof of larger-radius strengthening of locality input surfaces.
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

The weakest next admissible formal step is to revisit max-radius Boolean closure
using a common radius only when both inputs can be provided at that common
radius. Do not infer larger-radius strengthening from this lemma.
