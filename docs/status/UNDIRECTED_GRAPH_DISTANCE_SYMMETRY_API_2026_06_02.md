# Undirected Graph Distance Symmetry API — 2026-06-02

## Object

`UNDIRECTED_GRAPH_CLASS_DISTANCE_SYMMETRY_API`

## Status

`UNDIRECTED_GRAPH_DISTANCE_SYMMETRY_API_ADDED`

## Lean file

`FMT/Graph/UndirectedGraphDistanceSymmetryAPI.lean`

## Closed objects

- `UndirectedGraphClass`
- `SymmAdjProjectionFromUndirectedGraph`
- `DistanceSymmetryForUndirectedGraphClass`

## Boundary

This is an API layer only.

Distance symmetry is available without restating the adjacency-symmetry hypothesis only inside the explicit `UndirectedGraph` class.

This does not prove:

- every graph is undirected;
- distance symmetry for arbitrary directed graphs;
- a change to the underlying `Graph` structure.

## Next admissible object

`STOP_OR_REGISTER_DISTANCE_LAYER_FINAL_CLOSURE_STATUS`

## Weakest sufficient next input

`StopOrDistanceLayerFinalClosureStatus`
