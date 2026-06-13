# CSLIB-FMT Guarded Locality Pipeline

Status: `BOUNDED_GUARDED_LOCALITY_CLOSURE`

Closed bounded pipeline:

```text
PlainInducedRadiusBallIso
  → PointedRadiusBallEquiv
  → BallIso
  → ballIso_to_restricted_guarded_local_type_equivalent
  → LocalIso
  → guarded_rank_locality
  → restricted_guarded_rank_locality
  → RestrictedGuardedLocalTypeEquivalent
  → locality_pipeline_certificate
```

Non-claims:

```text
Full Gaifman locality
Unguarded FO locality
Fagin's Theorem
0-1 Law
```
