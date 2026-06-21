# Existential Body-Witness Locality Transport Type Shell

Status: `EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_TYPE_SHELL_ONLY`

The previous `Prop` shell failed because Lean reported the quantified target
has type `Type 1`, not `Prop`. This records the corrected type shell only.

## Lean type shell

~~~lean
def existential_body_witness_locality_transport_type : Type 1 :=
  ∀ {σ : RelLanguage} (M : RelStructure σ)
      {n : Nat} {φ : Formula σ (n + 1)},
    HasUnguardedFOLocalityRadius M φ →
      HasUnguardedFOLocalityRadius M (Formula.ex φ)
~~~

## Boundary

~~~text
BOUNDARY := ¬ existential_body_witness_locality_transport
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality
~~~
