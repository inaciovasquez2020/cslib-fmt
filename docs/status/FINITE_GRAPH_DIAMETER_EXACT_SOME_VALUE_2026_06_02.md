# Finite Graph Diameter Exact Some Value — 2026-06-02

Status: `TARGET_IMPLEMENTED_PENDING_VERIFICATION`

## Implemented object

```text
finiteGraphDiameter_eq_some_natListMax_of_allPairDistancesReachable
Meaning
If all finite ordered vertex-pair distances are reachable, then finiteGraphDiameter? is exactly:
some (natListMax (pairDistanceValues G).toList)
Boundary
This theorem does not claim:
directed distance symmetry
new connectedness closure
any change to Graph
a new diameter computation algorithm
Next admissible object
VerifyFiniteGraphDiameterExactSomeValue
