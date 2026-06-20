# UNGUARDED_FO_FORMULA_RADIUS_CONSTRUCTION_TARGET_2026_06_20

## Status

The formula-radius construction target for bounded syntactic fragments is present.

This does not construct locality radii. It defines the target shape for a future
bounded-fragment radius construction.

## Source file

`lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean`

## Depends on

- `lean/CSLIB/FMT/UnguardedFO/SyntaxSemantics.lean`
- `lean/CSLIB/FMT/UnguardedFO/Gaifman.lean`
- `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

## Standalone reason

Current package layout has no importable CSLIB module root; this frontier layer is direct-checked as a standalone module.

## Classification stratum

construction target surface with extraction lemmas

## Definitions

- `FormulaQuantifierDepth`
- `BoundedSyntacticFragment`
- `FormulaRadiusConstructionTarget`

## Extraction lemmas

- `formula_radius_construction_target_has_radius`
- `formula_radius_construction_target_radius_le`
- `formula_radius_construction_target_input`

## Next target

`bounded-fragment atomic and Boolean radius constructors`

## Nonclaims

- Does not claim general FMT closure.
- Does not claim Fagin theorem.
- Does not claim 0-1 Law.
- Does not claim full Gaifman locality.
- Does not claim unguarded FO locality theorem.
- Does not claim formula-radius construction theorem.
- Does not claim external validation.

## Boundary locks

- `BOUNDARY := ¬ Fagin theorem`
- `BOUNDARY := ¬ 0-1 Law`
- `BOUNDARY := ¬ full Gaifman locality`
- `BOUNDARY := ¬ unguarded FO locality theorem`
- `BOUNDARY := ¬ global finite-model-theory final theorem`
- `BOUNDARY := ¬ formula-radius construction theorem`
- `BOUNDARY := ¬ external validation claim`
