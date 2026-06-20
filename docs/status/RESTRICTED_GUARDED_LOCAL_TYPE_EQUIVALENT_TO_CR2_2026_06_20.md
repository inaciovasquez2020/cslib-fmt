# RESTRICTED_GUARDED_LOCAL_TYPE_EQUIVALENT_TO_CR2_2026_06_20

## Status

A constructor from restricted guarded local-type equivalence to `Cr2` is proved.

## Lean theorem

`restricted_guarded_local_type_equivalent_to_cr2`

## Source file

`lean/CSLIB/FMT/GuardedLocality/Pipeline.lean`

## Classification stratum

`conditional theorem`

## Proof route

RestrictedGuardedLocalTypeEquivalent → RestrictedEFGameLocalTypeInvariantInputSurface → Cr2

## Remaining gap

An arbitrary cross-structure Cr2 constructor without a restricted guarded local-type equivalence hypothesis remains unproved.

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
