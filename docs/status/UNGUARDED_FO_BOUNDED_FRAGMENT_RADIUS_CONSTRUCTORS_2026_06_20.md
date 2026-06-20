# Unguarded FO bounded-fragment radius constructors — 2026-06-20

STATUS := `BOUNDED_FRAGMENT_ATOMIC_BOOLEAN_RADIUS_CONSTRUCTORS`

BASE := `6894d3d theorem: add unguarded FO formula radius construction target`

ADDED_LAYER :=

- `singleton_bounded_syntactic_fragment`
- `atomic_bounded_syntactic_fragment`
- `singleton_radius_construction_target`
- `atomic_radius_constructor`
- `neg_radius_input`
- `neg_radius_constructor`
- `conj_radius_input`
- `conj_radius_constructor`
- `disj_radius_input`
- `disj_radius_constructor`

VALIDATED_SURFACE :=

The Lean layer gives singleton bounded-fragment constructors from explicit locality inputs, plus Boolean radius-input preservation for negation, conjunction, and disjunction.

BOUNDARY :=

Still no formula-radius construction theorem, no existence of atomic locality inputs, no radius monotonicity theorem, no closure of arbitrary bounded syntactic fragments, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.

NEXT_TARGET := bounded-fragment Boolean closure from target families with an explicit shared-radius invariant.
