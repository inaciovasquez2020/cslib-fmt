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
