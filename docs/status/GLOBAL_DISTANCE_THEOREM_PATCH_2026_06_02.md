# Global Distance Theorem Patch — 2026-06-02

## Object

`GLOBAL_DISTANCE_THEOREM_PATCH`

## Status

`CONDITIONAL_GLOBAL_DISTANCE_THEOREM_WRAPPERS_ADDED`

## Lean file

`FMT/Graph/GlobalDistanceTheorems.lean`

## Closed objects

- `GlobalDistanceSymmetryTheoremConditional`
- `GlobalDistanceTriangleTheoremConditional`

## Boundary

This patch adds global theorem wrappers only.

It does not prove:

- all graphs satisfy adjacency symmetry;
- all graphs satisfy `SLASHAxioms`;
- unconditional global distance symmetry;
- unconditional global triangle inequality.

## Next admissible object

`GLOBAL_DISTANCE_AXIOM_DISCHARGE_OR_STOP`

## Weakest sufficient next input

`ProofThatTargetGraphClassSatisfiesAdjacencySymmetryAndSLASHAxioms`
