# UNGUARDED_FO_LOCALITY_INPUT_SURFACE_2026_06_20

## Status

The unguarded FO locality input surface is present.

This does not prove unguarded FO locality. It defines the input shape needed to
state locality over Gaifman bounded-distance equivalence.

## Source file

`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

## Depends on

- `lean/CSLIB/FMT/UnguardedFO/SyntaxSemantics.lean`
- `lean/CSLIB/FMT/UnguardedFO/Gaifman.lean`

## Standalone reason

Current package layout has no importable CSLIB module root; this frontier layer is direct-checked as a standalone module.

## Classification stratum

input surface with projection lemmas

## Definitions

- `AssignmentGaifmanClose`
- `UnguardedFOLocalityInputSurface`
- `HasUnguardedFOLocalityRadius`

## Projection lemmas

- `unguarded_fo_locality_input_surface_invariant`
- `has_unguarded_fo_locality_radius_input`

## Next target

`formula-radius construction target for bounded syntactic fragments`

## Nonclaims

- Does not claim general FMT closure.
- Does not claim Fagin theorem.
- Does not claim 0-1 Law.
- Does not claim full Gaifman locality.
- Does not claim unguarded FO locality theorem.
- Does not claim external validation.

## Boundary locks

- `BOUNDARY := ¬ Fagin theorem`
- `BOUNDARY := ¬ 0-1 Law`
- `BOUNDARY := ¬ full Gaifman locality`
- `BOUNDARY := ¬ unguarded FO locality theorem`
- `BOUNDARY := ¬ global finite-model-theory final theorem`
- `BOUNDARY := ¬ external validation claim`
