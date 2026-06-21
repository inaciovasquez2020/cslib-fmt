# EXISTENTIAL_BODY_DISTINCT_WITNESS_ASSIGNMENT_EXTENSION_INVARIANCE_ONLY

ACHIEVED := existential_body_distinct_witness_assignment_extension_invariance_only

LEAN_OBJECT := existential_body_distinct_witness_assignment_extension_invariance

This proves only distinct-witness assignment-extension invariance for the existential body, assuming the two witnesses are already `r`-close.

BOUNDARY := ¬ existential_body_witness_locality_transport
BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality

MISSING_OBJECT := existential_body_witness_locality_transport
