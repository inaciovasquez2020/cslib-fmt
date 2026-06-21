# Existential Locality-Radius Constructor Missing-Theorem Status

Status: `EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_MISSING_THEOREM_STATUS_ONLY`

This status-lock records the weakest missing theorem after the proof-bearing
quantifier assignment radius-control statement has been exposed.

The missing theorem shape is:

```lean
∀ {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} {φ : Formula σ (n + 1)},
  HasUnguardedFOLocalityRadius M φ →
    HasUnguardedFOLocalityRadius M (Formula.ex φ)
This file records only a missing-theorem status. It does not prove the
existential locality-radius constructor and does not prove Pk1, 2vK, full
formula-radius construction, full quantifier locality transport, or full
unguarded FO locality.
Lean objects
def existential_locality_radius_constructor_missing_theorem_status : Prop :=
  TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status

theorem existential_locality_radius_constructor_missing_theorem_status_closed :
    existential_locality_radius_constructor_missing_theorem_status := by
  exact TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status_closed
Boundary
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_unguarded_fo_locality
