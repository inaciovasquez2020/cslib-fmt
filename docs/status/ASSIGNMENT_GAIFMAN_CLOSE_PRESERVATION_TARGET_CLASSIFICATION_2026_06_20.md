# AssignmentGaifmanClose preservation target classification

Date: 2026-06-20
After HEAD: `e8a8408`

## Status

`CLASSIFIED_IMPOSSIBLE_AS_UNCONDITIONAL_GLOBAL_TARGET`

## Classified target

```lean
AssignmentGaifmanClosePreservationTarget
Exact structural obstruction
AssignmentGaifmanClose is a pointwise bounded Gaifman-distance condition,
not an assignment-equality condition.
The target requires:
∀ ρ τ : Fin n → M.carrier,
  AssignmentGaifmanClose M r ρ τ →
  ∀ x : Fin n, ρ x = τ x
For positive radius, distinct adjacent elements may be Gaifman-close while not
equal. Therefore the target field ∀ x : Fin n, ρ x = τ x is stronger than
the current closeness data.
Classification
The target is impossible as an unconditional global target from the current
definitions.
Weakest strengthened assignment-close definition
AssignmentExactOnFreeVariables M ρ τ :=
  ∀ x : Fin n, ρ x = τ x
Weakest admissible replacement target
AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget
Boundary
This classification does not claim:
AssignmentGaifmanClosePreservationTarget is inhabited;
assignment equality follows from AssignmentGaifmanClose;
unconditional equality atom locality;
unconditional relation atom locality;
unconditional atomic_formula_locality_input_exists;
Boolean recursion;
quantifier recursion;
Gaifman locality.
Recursion gate
Boolean or quantifier recursion remains inadmissible until atomic preservation
is rebuilt using a valid replacement invariant.
