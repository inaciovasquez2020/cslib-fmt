# Common Smaller-Radius Conjunction Constructor Lock

Status: `COMMON_SMALLER_RADIUS_CONJUNCTION_CONSTRUCTOR_LOCK_OK`

Artifact:

- `artifacts/cslib_fmt/common_smaller_radius_conjunction_constructor_lock_2026_06_20.json`

Lean source:

- `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

Locked declaration:

- `unguarded_fo_conj_common_smaller_radius_constructor`

Predecessor declaration:

- `unguarded_fo_conj_same_radius_constructor`

This lock records that the common smaller-radius conjunction constructor is present in the Lean locality input surface at commit `b5231f7`.

Boundary:

`BOUNDARY := ¬ common_smaller_radius_disjunction_constructor`

This lock does not prove the common smaller-radius disjunction constructor, negation constructor, quantifier recursion gate admissibility, Boolean recursion gate completion, full unguarded FO locality, or the general finite model theorem.

Next bounded choice: add the common smaller-radius disjunction analogue only after this conjunction constructor lock is committed.
