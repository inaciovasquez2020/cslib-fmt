# Full Unguarded FO / Pk1 Route Gap Rank

Status: `FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_ONLY`

This document ranks the remaining bounded gaps for the public `cslib-fmt`
unguarded FO / Pk1 route. It does not prove any of the missing theorems.

## Ranked gaps

1. `existential_locality_radius_constructor`
2. `full_quantifier_locality_transport`
3. `full_formula_radius_construction`
4. `Pk1`
5. `2vK`

## Required theorem shape for the first gap

~~~lean
∀ {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} {φ : Formula σ (n + 1)},
  HasUnguardedFOLocalityRadius M φ →
    HasUnguardedFOLocalityRadius M (Formula.ex φ)
~~~

## Boundary

~~~text
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality
~~~
