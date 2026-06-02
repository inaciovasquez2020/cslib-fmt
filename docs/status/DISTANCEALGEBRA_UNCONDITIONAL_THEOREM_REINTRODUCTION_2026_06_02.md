# DistanceAlgebra Unconditional Theorem Reintroduction — 2026-06-02

## Status

`UNCONDITIONAL_THEOREM_REINTRODUCTION_PATCH_BUILDS`

## Input dependency

`DISTANCEALGEBRA_DISTANCE_THEOREM_REINTRODUCTION_SURFACE`

Closed by PR #150 at commit `9678e8a`.

## Closed objects

The patch closes the concrete `DistanceAlgebra` theorem-reintroduction target for the `Line3` graph.

Closed path witnesses:

- `lineGraph_path_ba`
- `lineGraph_path_cb`
- `lineGraph_path_ac_two`
- `lineGraph_path_ca_two`

Closed direct path-level outputs:

- `lineGraph_direct_path_symmetry_ab_ba`
- `lineGraph_direct_path_ac_le_two`

Closed dependency instance:

- `lineGraph_slashAxioms : FMT.Inputs.SLASHAxioms lineGraph`

Closed distance-level outputs:

- `lineGraph_dist_ab_le_one`
- `lineGraph_dist_ba_le_one`
- `lineGraph_dist_ab_ba_symmetry`
- `lineGraph_dist_ac_le_two`

## Dependency-axiom discharge

The missing concrete dependency was:

`FMT.Inputs.SLASHAxioms lineGraph`

It is discharged locally for the concrete `Line3` graph by the finite case-split instance `lineGraph_slashAxioms`.

## Boundary

- unconditional for the concrete `Line3` example graph
- not a global distance symmetry theorem for all graphs
- not a global distance triangle theorem for all graphs
- no broader FMT theorem promotion beyond `DistanceAlgebra`

## Next admissible object

`DISTANCEALGEBRA_UNCONDITIONAL_THEOREM_REINTRODUCTION_REPO_PR`
