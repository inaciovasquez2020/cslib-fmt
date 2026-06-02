# Global Distance Axiom Discharge — 2026-06-02

## Object

`GLOBAL_DISTANCE_AXIOM_DISCHARGE`

## Status

`SLASH_AXIOM_DISCHARGED_ADJACENCY_SYMMETRY_REMAINS_EXPLICIT`

## Lean file

`FMT/Graph/GlobalDistanceAxiomDischarge.lean`

## Closed objects

- `GlobalSLASHAxiomsDischarge`
- `GlobalDistanceTriangleTheoremUnconditionalOnSLASH`
- `GlobalDistanceSymmetryTheoremConditionalOnlyOnSymmAdj`

## Boundary

`SLASHAxioms` is discharged globally by `exists_min_pathLength`.

The triangle theorem no longer requires an explicit `SLASHAxioms` parameter.

Distance symmetry still requires `SymmAdj`, because directed graphs need not be symmetric.

This does not prove:

- every graph is undirected;
- unconditional distance symmetry for arbitrary directed graphs;
- removal of the adjacency-symmetry hypothesis.

## Next admissible object

`STOP_OR_UNDIRECTED_GRAPH_CLASS_DISTANCE_SYMMETRY_API`

## Weakest sufficient next input

`TargetUndirectedGraphClassOrStop`
