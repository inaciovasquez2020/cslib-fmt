# Unguarded FO conditional atomic locality targets lock

Date: 2026-06-20
After HEAD: `46b9e7e`

## Status

`CONDITIONAL_ATOMIC_TARGETS_ONLY_NO_UNCONDITIONAL_ATOMIC_LOCALITY`

This lock records the current atomic-locality frontier after adding the two
conditional atomic target constructors in
`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`.

## Locked conditional targets

### Equality atoms

Lean target:

```lean
equality_atom_locality_input_of_assignment_eq
Conclusion:
AtomicLocalityInput M (Formula.eq x y) 0
Required invariant:
∀ ρ τ : Fin n → M.carrier,
  AssignmentGaifmanClose M 0 ρ τ →
  ρ x = τ x ∧ ρ y = τ y
This invariant is not proved by the target.
Relation atoms
Lean target:
relation_atom_locality_input_of_interp_iff
Conclusion:
AtomicLocalityInput M (Formula.rel R args) r
Required invariant:
∀ ρ τ : Fin n → M.carrier,
  AssignmentGaifmanClose M r ρ τ →
  (M.interp R (fun i => ρ (args i)) ↔
   M.interp R (fun i => τ (args i)))
This invariant is not proved by the target.
Boundary
This lock does not claim:
unconditional atomic_formula_locality_input_exists;
unconditional equality atom locality;
unconditional relation atom locality;
Boolean recursion;
quantifier recursion;
Gaifman locality.
Weakest missing invariants
Assignment equality for referenced equality variables under
AssignmentGaifmanClose M 0.
Relation interpretation preservation for argument tuples under
AssignmentGaifmanClose M r.
Next admissible object
AtomicLocalityInvariantLedgerOrAssignmentTuplePreservationTarget
