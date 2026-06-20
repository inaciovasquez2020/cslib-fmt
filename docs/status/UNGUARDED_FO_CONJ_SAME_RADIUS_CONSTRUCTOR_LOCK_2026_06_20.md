# Unguarded FO Same-Radius Conjunction Constructor Lock

PROGRESS_ID := cslib_fmt_conjunction_constructor_lock_2026_06_20

STATUS := UNGUARDED_FO_CONJ_SAME_RADIUS_CONSTRUCTOR_LOCK_ONLY

This status lock records the same-radius conjunction constructor in the
unguarded FO staged Gaifman-locality frontier.

The locked Lean theorem is:

`unguarded_fo_conj_same_radius_constructor`

in:

`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

The theorem states only that already supplied locality input surfaces for `φ`
and `ψ` at the same radius `r` give a locality input surface for
`Formula.conj φ ψ` at the same radius `r`.

NONCLAIMS :=

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

The weakest next admissible formal step is disjunction-only same-radius
preservation from two already supplied same-radius input surfaces.
