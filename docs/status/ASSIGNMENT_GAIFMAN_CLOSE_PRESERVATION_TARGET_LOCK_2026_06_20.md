# AssignmentGaifmanClose preservation target lock

Date: 2026-06-20
After HEAD: `0031af2`

## Status

`ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_TARGET_LOCK_ONLY`

This lock records the target shell:

```lean
AssignmentGaifmanClosePreservationTarget
Locked target shape
structure AssignmentGaifmanClosePreservationTarget {σ : RelLanguage}
    (M : RelStructure σ) (r : Nat) (n : Nat) where
  preserves :
    ∀ ρ τ : Fin n → M.carrier,
      AssignmentGaifmanClose M r ρ τ →
      ∀ x : Fin n, ρ x = τ x
Boundary
This lock does not claim:
AssignmentGaifmanClosePreservationTarget is inhabited;
assignment preservation under AssignmentGaifmanClose;
unconditional equality atom locality;
unconditional relation atom locality;
unconditional atomic_formula_locality_input_exists;
Boolean recursion;
quantifier recursion;
Gaifman locality.
Required classification before recursion
Boolean or quantifier recursion remains inadmissible until
AssignmentGaifmanClosePreservationTarget is classified as one of:
impossible from the current AssignmentGaifmanClose definition;
conditional on a stronger assignment-close definition;
provable from existing definitions.
Next admissible object
AssignmentGaifmanClosePreservationTargetClassification
