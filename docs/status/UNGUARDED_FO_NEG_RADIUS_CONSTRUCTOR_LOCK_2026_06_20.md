# Unguarded FO Negation Radius Constructor Lock

PROGRESS_ID := cslib_fmt_negation_constructor_lock_2026_06_20

STATUS := UNGUARDED_FO_NEG_RADIUS_CONSTRUCTOR_LOCK_ONLY

This status lock records the first discharged Boolean constructor in the
unguarded FO staged Gaifman-locality frontier.

The locked Lean theorem is:

`unguarded_fo_neg_radius_constructor`

in:

`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

The theorem states only that an already supplied locality input surface for
`φ` at radius `r` gives a locality input surface for `Formula.neg φ` at the
same radius `r`.

NONCLAIMS :=

- No proof of conjunction closure.
- No proof of disjunction closure.
- No proof of shared-radius Boolean family recursion.
- No proof of max-radius Boolean recursion.
- No proof of existential quantifier recursion.
- No proof of arbitrary formula-radius construction.
- No proof of unguarded FO Gaifman locality.
- No proof of Fagin's theorem.
- No proof of the 0-1 Law.
- No proof of general finite model theory closure.

NEXT_BOUNDARY :=

The weakest next admissible formal step is conjunction-only radius preservation
from two already supplied same-radius input surfaces.
