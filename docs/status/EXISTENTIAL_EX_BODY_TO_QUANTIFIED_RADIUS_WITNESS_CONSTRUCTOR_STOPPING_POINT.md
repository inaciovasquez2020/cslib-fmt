# Existential Ex Body-to-Quantified Radius Witness Constructor Stopping Point

Status: `EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_ONLY`

This is a stopping point after the failed inhabitance attempt for
`existential_body_witness_locality_transport_type`.

The first failed direct proof attempt showed that a body witness cannot be reused
definitionally as an existential witness:

~~~text
hφ has type HasUnguardedFOLocalityRadius M φ
but is expected to have type HasUnguardedFOLocalityRadius M φ.ex
~~~

## Weakest missing object

`existential_ex_body_to_quantified_radius_witness_constructor`

This object must construct a witness of:

~~~lean
HasUnguardedFOLocalityRadius M (Formula.ex φ)
~~~

from a witness of:

~~~lean
HasUnguardedFOLocalityRadius M φ
~~~

It is required before proving `existential_body_witness_locality_transport` and before proving the existential locality-radius constructor.

## Stop condition

No proof is attempted here. This status only records the inspected stopping point and the next missing constructor.

## Boundary

~~~text
BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor
BOUNDARY := ¬ existential_body_witness_locality_transport
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality
~~~

## Refactor after constructor-frontier status target

ACHIEVED_FRONTIER_STATUS := existential_constructor_frontier_from_body_invariance_package_status_only

BODY_INVARIANCE_PACKAGE_OBJECT := existential_body_assignment_extension_invariance_component_package

CONSTRUCTOR_FRONTIER_STATUS_OBJECT := existential_constructor_frontier_from_body_invariance_package_status

This refactor preserves the constructor stopping-point/frontier lock while recording the committed constructor-frontier status target from the packaged body-invariance target to the remaining constructor gap.

BOUNDARY := ¬ existential_body_witness_locality_transport
BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality

MISSING_OBJECT := existential_ex_body_to_quantified_radius_witness_constructor
MISSING_OBJECT := existential_body_witness_locality_transport

## Refactor after constructor-obligation gap package

ACHIEVED_OBLIGATION_PACKAGE := existential_constructor_obligation_gap_package_status_only

BODY_INVARIANCE_PACKAGE_OBJECT := existential_body_assignment_extension_invariance_component_package

CONSTRUCTOR_FRONTIER_STATUS_OBJECT := existential_constructor_frontier_from_body_invariance_package_status

CONSTRUCTOR_OBLIGATION_GAP_PACKAGE_STATUS_OBJECT := existential_constructor_obligation_gap_package_status

This refactor preserves the constructor stopping-point/frontier lock while recording the non-forbidden obligation gap package. The package names the remaining transport and constructor gaps without proving either.

BOUNDARY := ¬ existential_body_witness_locality_transport
BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality

MISSING_OBJECT := existential_ex_body_to_quantified_radius_witness_constructor
MISSING_OBJECT := existential_body_witness_locality_transport
