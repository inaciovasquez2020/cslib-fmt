# Finite Graph Diameter Option Nat Definition — 2026-06-02

Status: `TARGET_IMPLEMENTED_PENDING_VERIFICATION`

Selected target: `FiniteGraphDiameterLayer`

Registration action: `RegisterFiniteGraphDiameterLayerTarget`

## Implemented objects

- `ConnectedGraph`
- `allVertexPairs`
- `pairDistance?`
- `allPairDistancesReachable`
- `pairDistanceValues`
- `finiteGraphDiameter?`
- `connected_implies_all_pair_distances_reachable`
- `finite_connected_graph_diameter_exists`
- `distance_mem_pairDistanceValues`
- `distance_le_diameter_of_finite_connected`

## Locked assumptions

```text
[Fintype G.Vertex]
[DecidableEq G.Vertex]
Empty graph convention
finiteGraphDiameter? defaults to some 0 through max?.getD 0 when the vertex-pair distance set is empty.
Boundary
This layer does not claim:
arbitrary directed graph distance symmetry
every graph is undirected
removal of SymmAdj for directed graphs
any change to the underlying directed Graph structure
Next admissible object
VerifyFiniteGraphDiameterOptionNatDefinition
