# GENERAL_FMT_FRONTIER_FIRST_ATTACK_LEDGER_2026_06_20

## Status

This is the first attack ledger for the general FMT frontier.

It does not close the general frontier. It fixes the admissible order of attack
so bounded `Cr2` closure is not mislabeled as global finite model theory.

## Current retained bounded lock

`RestrictedEFGameLocalTypeInvariantInputSurface → Cr2`

## First admissible target

`Unguarded FO syntax and semantics`

## First global theorem target after language

`Unguarded FO locality`

## Attack order

1. `Unguarded FO syntax and semantics` — missing-or-unlocked target surface. Cr2 is restricted guarded-locality machinery; general FMT first needs an unguarded FO language layer.
2. `Gaifman graph and distance for arbitrary finite structures` — missing-or-unlocked target surface. Unguarded FO locality requires structure-level locality geometry, not only the restricted guarded surface.
3. `Unguarded FO locality` — open. This is the closest global frontier theorem to the current guarded-locality work.
4. `Fagin theorem` — open. Requires ESO/NP encoding and finite-structure complexity machinery.
5. `0-1 Law` — open. Requires random finite structure/probability asymptotic layer.

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
