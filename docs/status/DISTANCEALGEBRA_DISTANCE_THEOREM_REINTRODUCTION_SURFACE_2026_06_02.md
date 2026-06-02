# DistanceAlgebra Distance-Theorem Reintroduction Surface — 2026-06-02

## Status

`TARGET_SURFACE_RECORDED_NO_THEOREM_REINTRODUCED`

## Input dependency

`DISTANCEALGEBRA_DEPENDENCY_AXIOM_OUTPUT_CLASSIFICATION`

Closed by PR #149 at commit `8451e64`.

## Current build surface

`FMT/Examples/DistanceAlgebra.lean` currently contains:

- `lineGraph_symm`
- `lineGraph_path_ab`
- `lineGraph_path_bc`

The former distance-level examples are not reintroduced here.

## Candidate theorem outputs

- `lineGraph_dist_ab_ba_symmetry`
- `lineGraph_dist_ac_le_two`

## Required dependency choices

One of the following must be supplied before theorem-level reintroduction:

1. buildable distance symmetry theorem on the current `Graph` interface
2. buildable distance triangle theorem on the current `Graph` interface
3. direct derivation from `PathLength` / `DistanceOrder` without obsolete imports

## Boundary

- target surface only
- no distance theorem reintroduced
- no dependency axiom discharged
- no broader FMT theorem promotion

## Next admissible object

`DISTANCEALGEBRA_DISTANCE_THEOREM_REINTRODUCTION_PATCH_OR_EXPLICIT_DEPENDENCY_AXIOM_DISCHARGE`
