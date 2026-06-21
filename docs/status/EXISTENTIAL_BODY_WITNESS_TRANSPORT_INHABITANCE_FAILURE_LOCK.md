# Existential Body-Witness Transport Inhabitance Failure Lock

Status: `EXISTENTIAL_BODY_WITNESS_TRANSPORT_INHABITANCE_FAILURE_LOCK_ONLY`

A single Lean inhabitance attempt was made for:

```lean
def existential_body_witness_locality_transport :
    existential_body_witness_locality_transport_type := by
  intro σ M n φ hφ
  exact hφ
```

Lean rejected the direct reuse of the body locality witness as a witness for
`Formula.ex φ`. The failed proof patch was reverted before this status-lock
was created.

## First error

```text
lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean:1158:2: error: Type mismatch
```

## Weakest missing object

`existential_ex_body_to_quantified_radius_witness_constructor`

This is the missing constructor that must transform a locality-radius witness
for the body formula into a locality-radius witness for the existential formula.

## Boundary

```text
BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor
BOUNDARY := ¬ existential_body_witness_locality_transport
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality
```

## Refactor after same-witness assignment-extension invariance

ACHIEVED_COMPONENT := existential_body_same_witness_assignment_extension_invariance_only

PROVED_WEAKER_COMPONENT := existential_body_same_witness_assignment_extension_invariance

This refactor preserves the transport-inhabitance failure lock while recording the strictly weaker committed same-witness component.

BOUNDARY := ¬ existential_body_witness_locality_transport
BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality

MISSING_OBJECT := existential_body_witness_locality_transport
MISSING_OBJECT := distinct_witness_assignment_extension_invariance

## Refactor after distinct-witness assignment-extension invariance

ACHIEVED_COMPONENT := existential_body_distinct_witness_assignment_extension_invariance_only

PROVED_WEAKER_COMPONENT := existential_body_same_witness_assignment_extension_invariance
PROVED_WEAKER_COMPONENT := existential_body_distinct_witness_assignment_extension_invariance

This refactor preserves the transport-inhabitance failure lock while recording both strictly weaker committed invariance components.

BOUNDARY := ¬ existential_body_witness_locality_transport
BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor
BOUNDARY := ¬ existential_locality_radius_constructor
BOUNDARY := ¬ full_quantifier_locality_transport
BOUNDARY := ¬ full_formula_radius_construction
BOUNDARY := ¬ Pk1
BOUNDARY := ¬ 2vK
BOUNDARY := ¬ full_unguarded_fo_locality

MISSING_OBJECT := existential_body_witness_locality_transport
MISSING_OBJECT := existential_ex_body_to_quantified_radius_witness_constructor
