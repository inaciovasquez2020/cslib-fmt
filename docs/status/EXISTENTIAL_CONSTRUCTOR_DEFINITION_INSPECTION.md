# Existential Constructor Definition Inspection

Status: `EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION_ONLY`

This records the bounded inspection step after the full unguarded FO / Pk1
route gap-rank. It inspects `HasUnguardedFOLocalityRadius` and `Formula.ex`
without proving the existential locality-radius constructor.

## Weakest next missing object

`existential_body_witness_locality_transport`

This is the next candidate lemma needed for:

```lean
∀ {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} {φ : Formula σ (n + 1)},
  HasUnguardedFOLocalityRadius M φ →
    HasUnguardedFOLocalityRadius M (Formula.ex φ)
The required content is a Lean lemma transporting a body-locality witness for
φ to a locality witness for Formula.ex φ, preserving the radius/witness
data required by HasUnguardedFOLocalityRadius.
Boundary
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ existential_body_witness_locality_transport
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality
