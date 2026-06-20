# BOUNDED_SURFACE_VERIFIED_LEMMA_CERTIFICATE_2026_06_19

## Status

This is a scoped bounded-surface verified-lemma certificate.

It certifies only the listed Lean declarations in one bounded distance-theorem family.
It is subordinate to `THEOREM_SURFACE_AUDIT`.

## Certified source file

`FMT/Graph/GlobalDistanceTheorems.lean`

## Classification stratum

`verified lemma`

## Certified declarations

- `theorem global_dist`
- `theorem global_dist`

## Dependency chain

- `FMT.Graph.DistSymm`
- `FMT.Graph.DistTriangle`

The dependency chain is read from the certified Lean source file imports.
This document does not claim closure beyond the listed declarations.

## Conditional hypotheses

The certified hypotheses are exactly the parameters and assumptions appearing in each listed Lean declaration.

## Nonclaims

- No general finite-model-theory closure is claimed.
- No unguarded FO locality theorem is claimed.
- No Fagin theorem or 0-1 Law result is claimed.
- No external validation or adoption claim is made.

## Boundary locks

- `BOUNDARY := ¬ Fagin theorem`
- `BOUNDARY := ¬ 0-1 Law`
- `BOUNDARY := ¬ full Gaifman locality`
- `BOUNDARY := ¬ unguarded FO locality`
- `BOUNDARY := ¬ global finite-model-theory final theorem`
- `BOUNDARY := ¬ external validation claim`
