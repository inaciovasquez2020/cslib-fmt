# PLAIN_INDUCED_RADIUS_BALL_ISOMORPHISM_TO_CR2_2026_06_19

## Status

Intermediate Cr2 theorem target.

## Lean theorem

`plain_induced_radius_ball_isomorphism_to_cr2`

## Source surface

`PlainInducedRadiusBallIso`

## Target surface

`Cr2`

## Proof path

`PlainInducedRadiusBallIso → RestrictedEFGameLocalTypeInvariantInputSurface → Cr2`

## Rank

Strictly weaker than `cr2_unconditional_constructor`.

Strictly stronger than `restricted_ef_game_local_type_invariant_input_surface_to_cr2`.

## Boundary

This theorem still requires a concrete plain induced radius-ball isomorphism hypothesis. It does not construct `Cr2` unconditionally.

## Boundary locks

- `BOUNDARY := ¬ cr2_unconditional_constructor`
- `BOUNDARY := ¬ arbitrary Cr2 witness`
- `BOUNDARY := ¬ unguarded FO locality`
- `BOUNDARY := ¬ full Gaifman locality`
- `BOUNDARY := ¬ Fagin theorem`
- `BOUNDARY := ¬ 0-1 Law`
- `BOUNDARY := ¬ repository-level final FMT closure`
