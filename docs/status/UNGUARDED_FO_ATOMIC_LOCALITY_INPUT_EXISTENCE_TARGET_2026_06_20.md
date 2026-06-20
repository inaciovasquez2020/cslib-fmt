# Unguarded FO atomic locality input existence target — 2026-06-20

STATUS := `ATOMIC_LOCALITY_INPUT_EXISTENCE_TARGET_ONLY`

SCOPE :=

Status/documentation scoped target only. No new Lean theorem is introduced by this layer.

PREVIOUS_GAP :=

`FORMULA_RADIUS_CONSTRUCTION_GAP_TARGET`

WEAKEST_MISSING_OBJECT :=

`atomic locality input existence`

TARGET_STATEMENT_SHAPE :=

- given an atomic formula, identify the exact locality input package that would be required
- record the obligation without asserting existence for arbitrary atoms
- keep the target below formula-radius recursive construction
- do not generalize finite Boolean fold access to arbitrary fragments

FORBIDDEN_CLAIMS :=

- existence for arbitrary atoms
- recursive formula-radius construction theorem
- arbitrary bounded-fragment closure
- unguarded FO locality theorem

BLOCKED_DOWNSTREAM_THEOREMS :=

- formula-radius construction theorem
- recursive formula syntax radius assignment
- fragment-membership bridge for all recursive construction outputs

ADMISSIBLE_NEXT_LAYER :=

- add a named atomic locality input obligation surface
- keep it conditional or target-only
- avoid constructing locality inputs for arbitrary atoms

BOUNDARY :=

This is an atomic locality input existence target only.

It does not assert existence for arbitrary atoms.

Still no atomic locality input existence, no formula-radius construction theorem, no arbitrary bounded-fragment closure, no radius monotonicity, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.

NEXT_TARGET := stop before any atomic existence theorem unless a concrete downstream theorem forces a named conditional obligation surface.
