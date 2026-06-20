# CR2_DISCHARGES_GUARDED_LOCALITY_INPUT_2026_06_19

## Status

`Cr2` conditionally discharges the existing guarded-locality input surface.

## Lean theorems

- `cr2_discharges_guarded_locality_input`
- `cr2_restricted_guarded_formula_invariant`

## Source file

`lean/CSLIB/FMT/GuardedLocality/Pipeline.lean`

## Classification stratum

`conditional theorem`

## Discharged surface

`RestrictedEFGameLocalTypeInvariantInputSurface`

## Conditional boundary

The discharge is conditional on a Cr2 witness; no arbitrary Cr2 constructor is claimed.

## Nonclaims

- No arbitrary Cr2 witness is constructed.
- No unguarded FO locality theorem is claimed.
- No full Gaifman locality theorem is claimed.
- No Fagin theorem or 0-1 Law result is claimed.
- No global finite-model-theory final theorem is claimed.
- No external-validation result is claimed.

## Boundary locks

- `BOUNDARY := ¬ Fagin theorem`
- `BOUNDARY := ¬ 0-1 Law`
- `BOUNDARY := ¬ full Gaifman locality`
- `BOUNDARY := ¬ unguarded FO locality`
- `BOUNDARY := ¬ global finite-model-theory final theorem`
- `BOUNDARY := ¬ external validation claim`
