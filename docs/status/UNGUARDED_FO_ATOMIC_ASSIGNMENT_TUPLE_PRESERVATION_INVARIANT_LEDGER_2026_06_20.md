# Unguarded FO atomic assignment/tuple preservation invariant ledger

Date: 2026-06-20
After HEAD: `9bf9fe7`

## Status

`ATOMIC_INVARIANT_LEDGER_ONLY_NO_PRESERVATION_PROOF`

This ledger records the two preservation invariants blocking unconditional
atomic locality after the conditional equality and relation atom targets were
committed.

## Depends on committed targets

```lean
equality_atom_locality_input_of_assignment_eq
relation_atom_locality_input_of_interp_iff
Ledgered invariant 1: equality assignment preservation
Needed for:
equality_atom_locality_input_of_assignment_eq
Statement:
∀ ρ τ : Fin n → M.carrier,
  AssignmentGaifmanClose M 0 ρ τ →
  ρ x = τ x ∧ ρ y = τ y
Status:
MISSING_UNPROVED_INVARIANT
Blocks:
unconditional equality atom locality
Ledgered invariant 2: relation tuple interpretation preservation
Needed for:
relation_atom_locality_input_of_interp_iff
Statement:
∀ ρ τ : Fin n → M.carrier,
  AssignmentGaifmanClose M r ρ τ →
  (M.interp R (fun i => ρ (args i)) ↔
   M.interp R (fun i => τ (args i)))
Status:
MISSING_UNPROVED_INVARIANT
Blocks:
unconditional relation atom locality
Boundary
This ledger does not claim:
unconditional atomic_formula_locality_input_exists;
unconditional equality atom locality;
unconditional relation atom locality;
assignment preservation under AssignmentGaifmanClose;
relation tuple interpretation preservation under AssignmentGaifmanClose;
Boolean recursion;
quantifier recursion;
Gaifman locality.
Recursion gate
Boolean or quantifier recursion is inadmissible until atomic preservation
invariants are classified.
Next admissible object
AssignmentGaifmanClosePreservationTargetOrTupleInterpretationPreservationTarget
