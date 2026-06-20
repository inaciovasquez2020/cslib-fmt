# UNGUARDED_FO_GAIFMAN_GRAPH_DISTANCE_2026_06_20

## Status

The second general-FMT frontier layer is present: Gaifman graph and bounded distance
for arbitrary finite relational structures.

## Source file

`lean/CSLIB/FMT/UnguardedFO/Gaifman.lean`

## Depends on

`lean/CSLIB/FMT/UnguardedFO/SyntaxSemantics.lean`

## Classification stratum

definition layer with basic verified lemmas

## Definitions

- `RelationTupleContains`
- `SameRelationTuple`
- `GaifmanAdjacent`
- `GaifmanWalk`
- `GaifmanDistanceLe`
- `GaifmanConnected`
- `FiniteRelStructure`
- `FiniteRelStructure.gaifmanAdjacent`
- `FiniteRelStructure.gaifmanDistanceLe`

## Verified lemmas

- `same_relation_tuple_symmetric`
- `gaifman_adjacent_symmetric`
- `gaifman_distanceLe_refl`
- `gaifman_connected_refl`
- `finite_gaifman_distanceLe_refl`

## Next target

`unguarded FO locality input surface`

## Nonclaims

- Does not claim general FMT closure.
- Does not claim Fagin theorem.
- Does not claim 0-1 Law.
- Does not claim full Gaifman locality.
- Does not claim unguarded FO locality.
- Does not claim external validation.

## Boundary locks

- `BOUNDARY := ¬ Fagin theorem`
- `BOUNDARY := ¬ 0-1 Law`
- `BOUNDARY := ¬ full Gaifman locality`
- `BOUNDARY := ¬ unguarded FO locality`
- `BOUNDARY := ¬ global finite-model-theory final theorem`
- `BOUNDARY := ¬ external validation claim`
