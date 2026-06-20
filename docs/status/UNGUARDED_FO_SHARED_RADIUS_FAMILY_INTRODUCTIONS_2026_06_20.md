# Unguarded FO shared-radius family introductions — 2026-06-20

STATUS := `SHARED_RADIUS_FAMILY_INTRODUCTIONS`

BASE := `4807ab4 theorem: add shared radius Boolean target family closure`

ADDED_LAYER :=

- `singleton_shared_radius_target_family`
- `atomic_shared_radius_target_family`
- `neg_shared_radius_target_family`
- `conj_shared_radius_target_family`
- `disj_shared_radius_target_family`

VALIDATED_SURFACE :=

This layer introduces `SharedRadiusTargetFamily` objects from explicit-radius inputs and from already-defined Boolean constructor outputs.

The singleton and atomic introductions require an explicit locality input at the selected radius.

The Boolean introductions remain target-family scoped. Negation preserves the same shared radius from one family. Conjunction and disjunction require a `SharedRadiusTargetFamilyPair`, including the explicit invariant:

`left.sharedRadius = right.sharedRadius`

BOUNDARY :=

Still no formula-radius construction theorem, no existence of atomic locality inputs, no radius monotonicity, no arbitrary bounded-fragment closure, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.

NEXT_TARGET := finite Boolean expression family fold under explicit shared-radius environment.
