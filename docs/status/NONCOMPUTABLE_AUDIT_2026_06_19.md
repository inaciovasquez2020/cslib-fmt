# NONCOMPUTABLE_AUDIT_2026_06_19

## Status

This is an internal audit of remaining `noncomputable def` declarations.

## Scope

`FMT.*` / `lean/CSLIB/FMT` source roots only.

## Result

- `entry_count`: `16`

## Entries

- `FMT/Graph/DistDef.lean:5` `dist` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Graph/Distance.lean:7` `dist` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Graph/DistanceCore.lean:6` `dist` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Graph/Edge.lean:17` `edgeCount` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Graph/FiniteGraphDiameter.lean:27` `pairDistance` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Graph/FiniteGraphDiameter.lean:47` `pairDistanceValues` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Graph/FiniteGraphDiameter.lean:91` `finiteGraphDiameter` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Graph/ShortestLength.lean:6` `shortestLength` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Graph/UndirectedEdge.lean:12` `undirectedEdgeCount` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Invariants/CycleQuotientProjection.lean:11` `cycleQuotientProjection` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Invariants/GenuineCycleRankV2.lean:8` `genuineCycleRankV2` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Invariants/GenuineCycleRankV2.lean:14` `genuineCycleSpaceOfGraphV2` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `FMT/Types/Factorization.lean:9` `factorsThrough_of_eq` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean:367` `neg_shared_radius_target_family_constructor` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean:413` `conj_shared_radius_target_family_constructor` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.
- `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean:470` `disj_shared_radius_target_family_constructor` — `justified-noncomputable`. Recorded as an existing noncomputable definition. This audit does not assert a constructive witness and therefore does not create a constructivization obligation.

## Policy

Every discovered `noncomputable def` is recorded as `justified-noncomputable` unless an already-existing constructive witness is explicitly identified.

No constructive witness is asserted by this audit.

## Nonclaims

- No constructivization obligation is created.
- No constructive replacement is claimed.
- No repository-level final FMT closure is claimed.

## Boundary locks

- `BOUNDARY := ¬ Fagin theorem`
- `BOUNDARY := ¬ 0-1 Law`
- `BOUNDARY := ¬ full Gaifman locality`
- `BOUNDARY := ¬ unguarded FO locality`
- `BOUNDARY := ¬ global finite-model-theory final theorem`
- `BOUNDARY := ¬ external validation claim`
