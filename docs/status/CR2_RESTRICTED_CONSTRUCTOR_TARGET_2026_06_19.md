# CR2_RESTRICTED_CONSTRUCTOR_TARGET_2026_06_19

## Status

Restricted constructor target weaker than `cr2_unconditional_constructor`.

## Lean theorem

`restricted_ef_game_local_type_invariant_input_surface_to_cr2`

## Source surface

`RestrictedEFGameLocalTypeInvariantInputSurface`

## Target surface

`Cr2`

## Proof shape

The theorem packages an existing restricted input witness as `Cr2` via `exact ⟨h⟩`.

## Boundary

This theorem does not construct `Cr2` for arbitrary structures, radius, and points without a restricted input witness.

## Boundary locks

- `BOUNDARY := ¬ cr2_unconditional_constructor`
- `BOUNDARY := ¬ arbitrary Cr2 witness`
- `BOUNDARY := ¬ unguarded FO locality`
- `BOUNDARY := ¬ full Gaifman locality`
- `BOUNDARY := ¬ Fagin theorem`
- `BOUNDARY := ¬ 0-1 Law`
- `BOUNDARY := ¬ repository-level final FMT closure`
